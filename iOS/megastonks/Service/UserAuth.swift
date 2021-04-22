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
        @Published var isLoggedin:Bool = false
    
    init() {
        if let _: String = KeychainWrapper.standard.string(forKey: "jwtToken"){
            isLoggedin = true
        }
        else{
            return
        }
       

    }

    func login(email:String, password:String, completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
            API().Authenticate(emailAddress: email, password:password) { result in
            response = result
                if result.isSuccessful{
                    DispatchQueue.main.async {
                        self.isLoggedin = true
                    }
                }
                completion(response)
            }
        }
    
    func logout() {
        let jwtRemoveSuccess: Bool = KeychainWrapper.standard.removeObject(forKey: "jwtToken")
        let refreshRemoveSuccess: Bool = KeychainWrapper.standard.removeObject(forKey: "refreshToken")
                if jwtRemoveSuccess && refreshRemoveSuccess{
                    DispatchQueue.main.async {
                        self.isLoggedin = false
                    }
                }
               
            }
        
    }
