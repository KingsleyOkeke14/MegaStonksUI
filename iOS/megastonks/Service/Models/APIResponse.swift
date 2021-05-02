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
    var stockSearchResponse:[StockSearchResult] = [StockSearchResult]()
    var stockInfoSearchStocksPage:StockSymbol?
    var stockHoldingResponse:StockHolding?
    var stockHoldingInfoPageResponse:StockHoldingInfoPage?
    var chartDataResponse: ChartData?
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


struct StockSearchElementResponse: Codable{
    let id: Int
    let symbol, companyName: String?
    let marketCap: Int?
    let sector, industry: String?
    let beta, price, lastAnnualDividend: Double?
    let volume: Int?
    let exchange, exchangeShortName, country: String?
    let isEtf, isActivelyTrading: Bool?
    let lastUpdated: String?
}

typealias StockSearchResponse = [StockSearchElementResponse]




struct HoldingsResponseElement: Codable {
    let id, stockId: Int
    let symbol, exchange: String?
    let changesPercentage, averageCost: Double?
    let quantity: Double?
    let marketValue, percentReturnToday, moneyReturnToday, percentReturnTotal: Double?
    let moneyReturnTotal, percentOfPortfolio: Double?
}




typealias HoldingsResponse = [HoldingsResponseElement]



struct HoldingResponseInfoPage: Codable {
    let id: Int?
    let averageCost: Double?
    let quantity, marketValue: Double?
    let percentReturnToday, moneyReturnToday, percentReturnTotal: Double?
    let moneyReturnTotal: Double?
    let percentOfPortfolio: Double?
    let lastUpdated: String?
}


struct ChartDataResponseElement: Codable {
    let date: String?
    let close: Double?
}

typealias ChartDataResponse = [ChartDataResponseElement]


struct WalletResponse: Codable {
    let firstName, lastName: String?
    let cash, initialDeposit, investments, total: Double?
    let percentReturnToday, moneyReturnToday, percentReturnTotal, moneyReturnTotal: Double?
}


struct CommonAPIResponse: Codable {
    let message: String
}
