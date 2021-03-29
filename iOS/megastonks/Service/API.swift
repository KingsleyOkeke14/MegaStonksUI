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
    
    func Authenticate(emailAddress: String, password: String) {
        let session = URLSession.shared
        let apiRoutes = APIRoutes()
        

        
        let task = session.dataTask(with: apiRoutes.auth!) { (data, response, error) in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
        }
        task.resume()
    }


}
