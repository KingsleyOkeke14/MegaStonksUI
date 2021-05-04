//
//  APIRequest.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-17.
//

import Foundation

class RegisterRequest: Codable {
    let title, firstName, lastName, email: String
    let password, confirmPassword, currency: String
    let acceptTerms: Bool

    init(title: String, firstName: String, lastName: String, email: String, password: String, confirmPassword: String, currency: String, acceptTerms: Bool) {
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
        self.currency = currency
        self.acceptTerms = acceptTerms
    }
}


class ResetPasswordRequest: Codable {
    let token, password, confirmPassword: String

    enum CodingKeys: String, CodingKey {
        case token
        case password = "Password"
        case confirmPassword = "ConfirmPassword"
    }

    init(token: String, password: String, confirmPassword: String) {
        self.token = token
        self.password = password
        self.confirmPassword = confirmPassword
    }
}

class AuthenticateRequest: Codable {
    let email, password: String

    enum CodingKeys: String, CodingKey {
        case email = "Email"
        case password = "Password"
    }

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

class TokenRequest: Codable {
    let token: String

    enum CodingKeys: String, CodingKey {
        case token = "Token"
    }

    init(token: String) {
        self.token = token
    }
}

class ForgotPasswordRequest: Codable {
    let email: String

    enum CodingKeys: String, CodingKey {
        case email = "Email"
    }

    init(email: String) {
        self.email = email
    }
}

class OrderStockRequest: Codable {

    let stockId: Int
    let orderType: String
    let orderAction: String
    let quantitySubmitted: Int

    init(stockId: Int, orderType: String, orderAction: String, quantitySubmitted: Int) {
        self.stockId = stockId
        self.orderType = orderType
        self.orderAction = orderAction
        self.quantitySubmitted = quantitySubmitted
    }
}
