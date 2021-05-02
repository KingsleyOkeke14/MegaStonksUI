//
//  User.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-24.
//

import Foundation

struct User{
    var firstName, lastName, emailAddress, currency : String
    var isOnBoarded:Bool
    
    init(firstName: String, lastName: String, emailAddress: String, currency: String, isOnBoarded: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.currency = currency
        self.isOnBoarded = isOnBoarded
    }
}
