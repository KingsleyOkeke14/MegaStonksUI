//
//  API.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-03-28.
//

import Foundation
import SwiftKeychainWrapper

struct APIRoutes {
    let server = "https://megastonksdev.azurewebsites.net/"
    let authRoute = "accounts/authenticate"
    let registerRoute = "accounts/register"
    let watchlistRoute = "watchlist/getwatchlist"
    
    var auth = URL(string: "")
    var register = URL(string: "")
    var watchList = URL(string: "")
    
    init() {
        auth = URL(string: server + authRoute)!
        register = URL(string: server + registerRoute)!
        watchList = URL(string: server + watchlistRoute)!
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
                    result.errorMessage = "Invalid Credentials. Please try Again"
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
                            print("name: \(cookie.name) value: \(cookie.value)")
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
    
    func GetWatchList(completion: @escaping (RequestResponse) -> ()) {

        var request = AppUrlRequest(url: apiRoutes.watchList!, httpMethod: "GET").request
        let jwtToken: String? = KeychainWrapper.standard.string(forKey: "jwtToken")
        request.setValue( "Bearer \(jwtToken!)", forHTTPHeaderField: "Authorization")
        
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
                    
                    //let jsonResponse = try? decoder.decode(WatchListResponses.self, from: result.data!)
                        //print(jsonResponse!)
                    if let jsonResponse = try? decoder.decode(WatchListResponse.self, from: result.data!) {
                        print(jsonResponse)
                    }
    
                        // make sure this JSON is in the format we expect
//                        if let jsonString = String(data: result.data!, encoding: .utf8) {
//                           print(jsonString)
//                        }
  
                }
                else if(httpResponse.statusCode == 401){
                 print("Unauthorized")
                 print(response!)
                    
                }
                else{
                    result.isSuccessful = false
                    result.errorMessage = "Could Not Retrieve WatchList"
                    print("Error Retrieving WatchList")
                    print(response!)
                }
            }
            completion(result)
        }
        task.resume()
    }
        

}
