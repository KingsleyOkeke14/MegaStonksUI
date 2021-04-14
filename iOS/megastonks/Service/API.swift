//
//  API.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-03-28.
//

import Foundation

struct APIRoutes {
    let server = "https://megastonksdev.azurewebsites.net/"
    let authRoute = "accounts/authenticate"
    let registerRoute = "accounts/register"
    
    var auth = URL(string: "")
    var register = URL(string: "")
    
    init() {
        auth = URL(string: server + authRoute)!
        register = URL(string: server + registerRoute)!
    }
   
}

struct API{
    let session = URLSession.shared
    let apiRoutes = APIRoutes()
    
    func Authenticate(emailAddress: String, password: String, completion: @escaping (RequestResponse) -> ()) {

        var request = URLRequest(url: apiRoutes.auth!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var result = RequestResponse()
        
        let json = [
            "Email": emailAddress,
            "Password": password
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
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
                }
            }
            
            
            completion(result)
            print("Attempted Login")
            //print(result.data!)
            //print(response!)
            if result.data != nil {
                print(String(data: result.data!, encoding: .utf8)!)
            }
            
        }
        task.resume()
    }
}
