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

struct AuthenticateResponse: Codable {
    let id: Int
    let title, firstName, lastName, email: String
    let role, created: String
    let isVerified: Bool
    let jwtToken: String
}

struct WatchListElement: Codable {
    let stockID: Int
    let symbol, name, watchListDescription: String
    let price: Double
    let currency: String
    let changesPercentage, change, dayLow, dayHigh: Double
    let yearHigh, yearLow: Double
    let marketCap: Int
    let priceAvg50, priceAvg200: Double
    let volume, avgVolume: Int
    let exchange: String
    let watchListOpen, previousClose: Double
    let isInWatchList, isInPortfolio: Bool

    enum CodingKeys: String, CodingKey {
        case stockID = "stockId"
        case symbol, name
        case watchListDescription = "description"
        case price, currency, changesPercentage, change, dayLow, dayHigh, yearHigh, yearLow, marketCap, priceAvg50, priceAvg200, volume, avgVolume, exchange
        case watchListOpen = "open"
        case previousClose, isInWatchList, isInPortfolio
    }
}

typealias WatchListResponse = [WatchListElement]
