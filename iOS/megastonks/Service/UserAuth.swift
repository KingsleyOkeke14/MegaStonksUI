//
//  UserAuth.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-12.
//

import Combine
import Foundation

class UserAuth: ObservableObject {
        @Published var isLoggedin:Bool = false

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
        //return response
        }
    }
