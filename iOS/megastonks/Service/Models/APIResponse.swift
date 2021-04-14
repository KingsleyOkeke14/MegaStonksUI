//
//  APIResponse.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-03-30.
//

import Foundation

struct RequestResponse{
    var isSuccessful:Bool = false
    var data:Data? = nil
    var errorMessage:String = ""
}
