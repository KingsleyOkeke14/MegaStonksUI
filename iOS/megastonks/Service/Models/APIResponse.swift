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
    var watchListResponse:[StockSymbol] = [StockSymbol]()
}

struct AuthenticateResponse: Codable {
    let id: Int
    let title, firstName, lastName, email: String
    let role, currency: String
    let isOnboarded: Bool
    let created: String
    let isVerified: Bool
    let jwtToken: String
}

struct StockElementResponse: Codable {
    let stockId: Int
    let symbol, name, description: String?
    let price: Double?
    let currency: String?
    let changesPercentage, change, dayLow, dayHigh: Double?
    let yearHigh, yearLow: Double?
    let marketCap: Int?
    let priceAvg50, priceAvg200: Double?
    let volume, avgVolume: Int?
    let exchange: String?
    let open, previousClose: Double?
    let isInWatchList, isInPortfolio: Bool

}

typealias StockListResponse = [StockElementResponse]


struct CommonAPIResponse: Codable {
    let message: String
}
