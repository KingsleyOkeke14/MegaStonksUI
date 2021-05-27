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
    var stockWatchListResponse:[StockSymbol] = [StockSymbol]()
    var stockSearchResponse:[StockSearchResult] = [StockSearchResult]()
    var stockInfoSearchStocksPage:StockSymbol?
    var stockHoldingResponse:StockHolding?
    var stockHoldingsResponse:StockHoldings?
    var stockHoldingInfoPageResponse:StockHoldingInfoPage?
    var stockChartDataResponse: ChartData?
    var orderHistoryResponse: [OrderHistoryElement] = OrderHistory(orderArray: [OrderHistoryResponseElement]()).history
    var orderStockResponse: OrderResultInfo?
    var walletResponse: UserWallet?
    var adResponse: AdData?
    var newsResponse: [NewsElement]?
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




struct StockHoldingsResponseElement: Codable {
    let id, stockId: Int
    let symbol, exchange: String?
    let changesPercentage, averageCost: Double?
    let quantity: Double?
    let marketValue, percentReturnToday, moneyReturnToday, percentReturnTotal: Double?
    let moneyReturnTotal, percentOfPortfolio: Double?
}


struct OrderHistoryResponseElement: Codable {
    let id: Int?
    let symbol: String?
    let name: String?
    let orderType: String?
    let orderStatus: String?
    let orderAction: String?
    let quantitySubmitted, quantityFilled, commission: Double?
    let pricePerShare, totalPriceFilled, totalCost: Double?
    let dateSubmitted, dateFilled: String?
}

typealias OrderHistoryResponse = [OrderHistoryResponseElement]


typealias HoldingsResponse = [StockHoldingsResponseElement]


struct HoldingResponseInfoPage: Codable {
    let id: Int?
    let averageCost: Double?
    let quantity, marketValue: Double?
    let percentReturnToday, moneyReturnToday, percentReturnTotal: Double?
    let moneyReturnTotal: Double?
    let percentOfPortfolio: Double?
    let lastUpdated: String?
}

struct OrderStockResponse: Codable {
    let name, stockSymbol, currency, orderType: String?
    let orderStatus, orderAction: String?
    let quantitySubmitted, quantityFilled, commission: Double?
    let pricePerShare, totalPriceFilled, totalCost, forexExchangeRate: Double?
    let exchangeResult: Double?
    let dateSubmitted, dateFilled: String?
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

struct AdsResponseElement: Codable {
    let id: Int?
    let company, title, adsResponseDescription: String?
    let imageURL: String?
    let urlToLoad: String?
    let dateAdded, expiryDate, lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case id, company, title
        case adsResponseDescription = "description"
        case imageURL = "imageUrl"
        case urlToLoad, dateAdded, expiryDate, lastUpdated
    }
}

typealias AdsResponse = [AdsResponseElement]


struct NewsResponseElement: Codable {
    let symbol: String?
    let publishedDate, title: String?
    let image: String?
    let site, text: String?
    let url: String?
}


typealias NewsResponse = [NewsResponseElement]


struct CommonAPIResponse: Codable {
    let message: String
}
