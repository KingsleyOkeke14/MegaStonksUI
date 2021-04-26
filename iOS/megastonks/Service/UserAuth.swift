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
    
    
    
    init() {
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
                
                response.isSuccessful = true
                response.errorMessage = ""
            }
            DispatchQueue.main.async {
                self.user = User(firstName: "", lastName: "", emailAddress: "", currency: "", isOnBoarded: true)
            }
            completion(response)
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
                        print("Login Successfull")
                    }
                }
                else{
                    
                    if(isFirstLogin){
                        DispatchQueue.main.async {
                            self.user = User(firstName: "", lastName: "", emailAddress: "", currency: "", isOnBoarded: true)
                            self.isLoggedin = false

                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.showAuthError = true
                        }
        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                            self.user = User(firstName: "", lastName: "", emailAddress: "", currency: "", isOnBoarded: true)
                            self.isLoggedin = false
                            self.showAuthError = false
                            print("Login Failed #1")
                        }
                    }

                }
            }
        }
        else{
            self.isLoggedin = false
            print("Login Failed #2")
        }
        
    }
    
}
