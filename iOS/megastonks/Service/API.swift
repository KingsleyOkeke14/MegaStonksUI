//
//  API.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-03-28.
//

import Foundation
import SwiftKeychainWrapper

struct APIRoutes {
    private let server:String
    let domain = "megastonksdev.azurewebsites.net"
    private let authRoute = "accounts/authenticate"
    private let registerRoute = "accounts/register"
    private let watchlistRoute = "watchlist/getwatchlist"
    private let revokeTokenRoute = "accounts/revoke-token"
    private let refreshTokenRoute = "accounts/refresh-token"
    private let forgotPasswordRoute = "accounts/forgot-password"
    private let resetPasswordRoute = "accounts/reset-password"
    private let onBoardRoute = "accounts/onboard-completed"
    
    
    var auth = URL(string: "")
    var register = URL(string: "")
    var watchList = URL(string: "")
    var revokeToken = URL(string: "")
    var refreshToken = URL(string: "")
    var forgotPassword = URL(string: "")
    var resetPassword = URL(string: "")
    var onBoard = URL(string: "")
    
    init() {
        server = "https://\(domain)/"
        auth = URL(string: server + authRoute)!
        register = URL(string: server + registerRoute)!
        watchList = URL(string: server + watchlistRoute)!
        revokeToken = URL(string: server + revokeTokenRoute)!
        refreshToken = URL(string: server + refreshTokenRoute)!
        forgotPassword = URL(string: server + forgotPasswordRoute)!
        resetPassword = URL(string: server + resetPasswordRoute)!
        onBoard = URL(string: server + onBoardRoute)!
    }
    
}

struct AppUrlRequest {
    var request:URLRequest
    
    init(url:URL, httpMethod:String) {
        request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    }
    
}

struct API{
    let session = URLSession.shared
    let apiRoutes = APIRoutes()
    let decoder = JSONDecoder()
    
    func Authenticate(emailAddress: String, password: String, completion: @escaping (RequestResponse) -> ()) {
        
        let request = AppUrlRequest(url: apiRoutes.auth!, httpMethod: "POST").request
        
        
        var result = RequestResponse()
        
        let authRequest = AuthenticateRequest(email: emailAddress, password: password)
        
        let jsonData = try! JSONEncoder().encode(authRequest)
        
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            
            //if let data = data, let jsonString = String(data: data, encoding: .utf8) {
            //    print(jsonString)
            //}
            
            result.data = data
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                return
            }
            
            
            
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode != 200{
                    result.isSuccessful = false
                    
                    if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                        result.errorMessage = jsonResponse.message
                    }
                    else{
                        result.errorMessage = "Invalid Credentials. Please try Again"
                    }
                    print("Error Logging In")
                }
                else {
                    result.isSuccessful = true
                    let fields = httpResponse.allHeaderFields as? [String :String]
                    
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields!, for: response!.url!)
                    for cookie in cookies {
                        if(cookie.name == "refreshToken"){
                            let saveSuccessful: Bool = KeychainWrapper.standard.set(cookie.value, forKey: cookie.name)
                            print("KeyChain Store Result is \(saveSuccessful)")
                        }
                        
                    }
                    
                }
            }
            
            
            completion(result)
            print("Attempted Login")
            //print(result.data!)
            //print(response!)
            if result.data != nil {
                
                
                if let jsonResponse = try? decoder.decode(AuthenticateResponse.self, from: result.data!) {
                    KeychainWrapper.standard.set(jsonResponse.jwtToken, forKey: "jwtToken")
                }
                
            }
            
        }
        task.resume()
    }
    
    func RefreshToken(token: String, completion: @escaping (RequestResponse) -> ()) {
        
        let request = AppUrlRequest(url: apiRoutes.refreshToken!, httpMethod: "POST").request
        
        var result = RequestResponse()
        
            
            if let cookie = HTTPCookie(properties: [
                .domain: APIRoutes().domain,
                .path: "/",
                .name: "refreshToken",
                .value: token,
                .secure: "FALSE",
                .discard: "TRUE"
            ]) {
                HTTPCookieStorage.shared.setCookie(cookie)
            }
            
            
            let jsonData = try! JSONEncoder().encode("")
            
            let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
                
                
                result.data = data
                
                if error != nil || data == nil {
                    print("Client error!")
                    print("Error is \(error!)")
                    return
                }
                
                
                
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode != 200{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Error Refreshing Token"
                        }
                        print(result.errorMessage)
                    }
                    else {
                        result.isSuccessful = true
                        let fields = httpResponse.allHeaderFields as? [String :String]
                        
                        let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields!, for: response!.url!)
                        for cookie in cookies {
                            if(cookie.name == "refreshToken"){
                                let saveSuccessful: Bool = KeychainWrapper.standard.set(cookie.value, forKey: cookie.name)
                                print("KeyChain Store Result is \(saveSuccessful)")
                            }
                            
                        }
                        
                        if result.data != nil {
                            if let jsonResponse = try? decoder.decode(AuthenticateResponse.self, from: result.data!) {
                                KeychainWrapper.standard.set(jsonResponse.jwtToken, forKey: "jwtToken")
                            }
                            
                        }
                        
                    }
                }
                
                completion(result)
            }
            task.resume()
        
         
    }
    
    func RevokeToken(completion: @escaping (RequestResponse) -> ()) {
        
        var result = RequestResponse()
        var revokeTokenRequest: TokenRequest = TokenRequest(token: "")
        var request = AppUrlRequest(url: apiRoutes.revokeToken!, httpMethod: "POST").request
        
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        }
        
        
        if let refreshToken: String = KeychainWrapper.standard.string(forKey: "refreshToken"){
            revokeTokenRequest = TokenRequest(token: refreshToken)
        }
        
        
        let jsonData = try! JSONEncoder().encode(revokeTokenRequest)
        
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            
            
            result.data = data
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode != 200{
                    result.isSuccessful = false
                    
                    if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                        result.errorMessage = jsonResponse.message
                    }
                    else{
                        result.errorMessage = "Unauthorized"
                    }
                    
                    print("User is Unauthorized to Revoke the Token")
                }
                else{
                    result.isSuccessful = true
                    KeychainWrapper.standard.removeObject(forKey: "refreshToken")
                    KeychainWrapper.standard.removeObject(forKey: "jwtToken")
                }
                
            }
            completion(result)
            
        }
        task.resume()
    }
    
    func ForgotPassword(emailAddress:String, completion: @escaping (RequestResponse) -> ()) {
        
        var result = RequestResponse()
        let forgotPasswordRequest: ForgotPasswordRequest = ForgotPasswordRequest(email: emailAddress)
        let request = AppUrlRequest(url: apiRoutes.forgotPassword!, httpMethod: "POST").request
        
        let jsonData = try! JSONEncoder().encode(forgotPasswordRequest)
        
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            
            result.data = data
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode == 200{
                    result.isSuccessful = true
                }
                else{
                    result.isSuccessful = false
                    
                    if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                        result.errorMessage = jsonResponse.message
                    }
                    else{
                        result.errorMessage = "Error: Please Enter a Valid Email Address to Request a Reset Token"
                    }
                    
                }
            }
            completion(result)
            
        }
        task.resume()
    }
    
    func Register(firstName: String, lastName: String, email: String, password: String, confirmPassword: String, currency: String, acceptTerms: Bool, completion: @escaping (RequestResponse) -> ()) {
        
        var result = RequestResponse()
        let registerRequest: RegisterRequest = RegisterRequest(title: "", firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword, currency: currency, acceptTerms: acceptTerms)
        let request = AppUrlRequest(url: apiRoutes.register!, httpMethod: "POST").request
        
        let jsonData = try! JSONEncoder().encode(registerRequest)
        
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            result.data = data
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode == 200{
                    result.isSuccessful = true
                }
                else{
                    result.isSuccessful = false
                    if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                        result.errorMessage = jsonResponse.message
                    }
                    else{
                        result.errorMessage = "Error Registering User"
                    }
                    
                }
            }
            completion(result)
            
        }
        task.resume()
    }
    
    func ResetPassword(token:String, newpassword:String, confirmPassword:String, completion: @escaping (RequestResponse) -> ()) {
        
        var result = RequestResponse()
        let resetPasswordRequest = ResetPasswordRequest(token: token, password: newpassword, confirmPassword: confirmPassword)
        let request = AppUrlRequest(url: apiRoutes.resetPassword!, httpMethod: "POST").request
        
        let jsonData = try! JSONEncoder().encode(resetPasswordRequest)
        
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            
            
            result.data = data
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode == 200{
                    result.isSuccessful = true
                }
                else{
                    result.isSuccessful = false
                    
                    if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                        result.errorMessage = jsonResponse.message
                    }
                    else{
                        result.errorMessage = "Error: Invalid Token or Password. Password Length must be greater than 5 characters and both Passwords should match"
                    }
                    
                    
                }
            }
            completion(result)
            
        }
        task.resume()
    }
    
    func GetWatchList(completion: @escaping (RequestResponse) -> ()) {
        
        var request = AppUrlRequest(url: apiRoutes.watchList!, httpMethod: "GET").request
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue( "Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            var result = RequestResponse()
            
            let task = session.dataTask(with: request) { (data, response, error) in
                result.data = data
                
                if error != nil || data == nil {
                    print("Client error!")
                    print("Error is \(error!)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200 ||  httpResponse.statusCode == 201{
                        
                        result.isSuccessful = true
                    }
                    else if(httpResponse.statusCode == 401){
                        print("Unauthorized")
                        print(response!)
                        
                    }
                    else{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Could Not Retrieve WatchList"
                        }
                        
                    }
                }
                completion(result)
                
                
            }
            task.resume()
            
            
        }
        
        
    }
    
    func OnBoardCompleted() {
        
        var request = AppUrlRequest(url: apiRoutes.onBoard!, httpMethod: "POST").request
        if let jwtToken: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            request.setValue( "Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            
            var result = RequestResponse()
            
            let jsonData = try! JSONEncoder().encode("")
            
            let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
                result.data = data
                
                if error != nil || data == nil {
                    print("Client error!")
                    print("Error is \(error!)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    if httpResponse.statusCode == 200{
                        
                        result.isSuccessful = true
                    }
                    else if(httpResponse.statusCode == 401){
                        print("Unauthorized")
                        print(response!)
                        
                    }
                    else{
                        result.isSuccessful = false
                        
                        if let jsonResponse = try? decoder.decode(CommonAPIResponse.self, from: result.data!){
                            result.errorMessage = jsonResponse.message
                        }
                        else{
                            result.errorMessage = "Couldn Not OnBoard User"
                        }
                        
                    }
                }
                
                
            }
            task.resume()
            
            
        }
        
        
    }
}
