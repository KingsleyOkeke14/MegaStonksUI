//
//  UserAuth.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-12.
//

import Combine
import Foundation
import SwiftKeychainWrapper

class UserAuth: ObservableObject {
    @Published var isLoggedin:Bool?
    @Published var user:User = User(firstName: "", lastName: "", emailAddress: "", currency: "", isOnBoarded: true)
    @Published var showAuthError:Bool = false
    @Published var isRefreshingAuth:Bool = false
    @Published var isInChatMode:Bool = false
    @Published var isChatLoggedIn:Bool = false
    
    init() {
        user.emailAddress = KeychainWrapper.standard.string(forKey: "EmailAddress") ?? ""
        refreshLogin(isFirstLogin: true)
    }
    
    func login(email:String, password:String, completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().Authenticate(emailAddress: email, password:password) { result in
            response = result
            if result.isSuccessful{
                let jsonResponse = try! JSONDecoder().decode(AuthenticateResponse.self, from: result.data!)
                DispatchQueue.main.async {
                    self.user = User(firstName: jsonResponse.firstName, lastName: jsonResponse.lastName, emailAddress: jsonResponse.email, currency: jsonResponse.currency, isOnBoarded: jsonResponse.isOnboarded)
                    self.isLoggedin = true
                }
                
                
            }
            completion(response)
        }
    }
    
    func logout(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        
        response.errorMessage = "Error Logging Out"
        API().RevokeToken(){ result in
            if(result.isSuccessful){
                response.isSuccessful = true
                response.errorMessage = ""
            }
            else{
                _  = KeychainWrapper.standard.removeObject(forKey: "jwtToken")
                _  = KeychainWrapper.standard.removeObject(forKey: "refreshToken")
                _  = KeychainWrapper.standard.removeObject(forKey: "EmailAddress")
                
                response.isSuccessful = true
                response.errorMessage = ""
            }
            DispatchQueue.main.async {
                self.user = User(firstName: "", lastName: "", emailAddress: "", currency: "", isOnBoarded: true)
            }
            completion(response)
        }
    }
    
    func checkTimeStampForAuth(){
        if let sessionTimeStamp: String = KeychainWrapper.standard.string(forKey: "sessionTimeStamp"){
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let sessionTimeStampToDate = format.date(from: sessionTimeStamp)
            if(sessionTimeStampToDate != nil){
                let dateToCheck = Date().addingTimeInterval(-3600)
                if(sessionTimeStampToDate! < dateToCheck){
                    isRefreshingAuth = true
                    refreshLogin()
                }
            }
        }
        else{
            isRefreshingAuth = false
        }
    }
    
    @objc func refreshLogin(isFirstLogin: Bool = false){
        print("Refresh Login...")
        if let refreshToken: String = KeychainWrapper.standard.string(forKey: "refreshToken"){
            API().RefreshToken(token: refreshToken){ result in
                if(result.isSuccessful){
                    let jsonResponse = try! JSONDecoder().decode(AuthenticateResponse.self, from: result.data!)
                    
                    DispatchQueue.main.async {
                        self.user = User(firstName: jsonResponse.firstName, lastName: jsonResponse.lastName, emailAddress: jsonResponse.email, currency: jsonResponse.currency, isOnBoarded: jsonResponse.isOnboarded)
                        self.isLoggedin = true
                        self.isRefreshingAuth = false
                        print("Login Successfull")
                    }
                }
                else{
                    
                    if(isFirstLogin){
                        DispatchQueue.main.async {
                            _  = KeychainWrapper.standard.removeObject(forKey: "jwtToken")
                            _  = KeychainWrapper.standard.removeObject(forKey: "refreshToken")
                            //self.user = User(firstName: "", lastName: "", emailAddress: "", currency: "", isOnBoarded: true)
                            self.isLoggedin = false
                            self.isRefreshingAuth = false
                        }
                    }
                    else{
                        //Basically a haflass implementation of retry of the auth token refresh
                        API().RefreshToken(token: refreshToken){ result in
                            if(result.isSuccessful){
                                let jsonResponse = try! JSONDecoder().decode(AuthenticateResponse.self, from: result.data!)
                                
                                DispatchQueue.main.async {
                                    self.user = User(firstName: jsonResponse.firstName, lastName: jsonResponse.lastName, emailAddress: jsonResponse.email, currency: jsonResponse.currency, isOnBoarded: jsonResponse.isOnboarded)
                                    self.isLoggedin = true
                                    self.isRefreshingAuth = false
                                    print("Login Successfull")
                                }
                            }
                            else{
                                DispatchQueue.main.async {
                                    self.showAuthError = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                    _  = KeychainWrapper.standard.removeObject(forKey: "jwtToken")
                                    _  = KeychainWrapper.standard.removeObject(forKey: "refreshToken")
                                    //self.user = User(firstName: "", lastName: "", emailAddress: "", currency: "", isOnBoarded: true)
                                    self.isLoggedin = false
                                    self.showAuthError = false
                                    self.isRefreshingAuth = false
                                    print("Login Failed #1")
                                }
                            }
                        }
                    }
                }
            }
        }
        else{
            _  = KeychainWrapper.standard.removeObject(forKey: "jwtToken")
            _  = KeychainWrapper.standard.removeObject(forKey: "refreshToken")
            self.isLoggedin = false
            self.isRefreshingAuth = false
            print("Login Failed #2")
        }
        
    }
    
}
