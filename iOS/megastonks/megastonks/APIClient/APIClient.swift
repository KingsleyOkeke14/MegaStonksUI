//
//  APIClient.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-01-09.
//

import Foundation
import UIKit

struct APIClient {
    
    struct APIRoutes {
        let server:String
        #if DEBUG
        let domain = "megastonksdev.azurewebsites.net"
        #else
        let domain = "megastonksprod.azurewebsites.net"
        #endif
        
        //Account
        private let authRoute = "account/authenticate"
        private let registerRoute = "account/register"
        
        var auth: URL
        var register: URL
        
        init() {
            server = "https://\(domain)/"
            auth = URL(string: server + authRoute)!
            register = URL(string: server + registerRoute)!
        }
    }
    
    var routes: APIRoutes
}
