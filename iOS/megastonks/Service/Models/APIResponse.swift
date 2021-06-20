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
    var cryptoWatchListResponse:[CryptoSymbol] = [CryptoSymbol]()
    var stockSearchResponse:[StockSearchResult] = [StockSearchResult]()
    var cryptoSearchResponse:[CryptoSearchResult] = [CryptoSearchResult]()
    var stockInfoSearchStocksPage:StockSymbol?
    var cryptoInfoSearchCryptosPage:CryptoSymbol?
    var stockHoldingResponse:StockHolding?
    var stockHoldingsResponse:StockHoldings?
    var cryptoHoldingResponse:CryptoHolding?
    var cryptoHoldingsResponse:CryptoHoldings?
    var holdingInfoPageResponse:HoldingInfoPage?
    var chartDataResponse: ChartData?
    var orderStockHistoryResponse: [OrderStockHistoryElement] = OrderStockHistory(orderArray: [OrderStockHistoryResponseElement]()).history
    var orderStockResponse: OrderStockResultInfo?
    var orderCryptoResponse: OrderCryptoResultInfo?
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

struct CryptoHoldingsResponseElement: Codable {
    let id, cryptoId: Int?
    let name, symbol: String?
    let logo: String?
    let averageCost, quantity, marketValue, percentReturnToday: Double?
    let moneyReturnToday, percentReturnTotal, moneyReturnTotal, percentOfPortfolio: Double?
}


struct OrderStockHistoryResponseElement: Codable {
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


struct OrderCryptoResponse: Codable {
    let name, cryptoSymbol: String?
    let logo: String?
    let orderType, orderStatus, orderAction: String?
    let quantitySubmitted, quantityFilled, commission: Double?
    let pricePerShare, totalPriceFilled, totalCost: Double?
    let forexExchangeRate, exchangeResult: Double?
    let dateSubmitted, dateFilled: String?
}

typealias OrderCryptoHistoryResponse = [OrderCryptoResponse]

typealias OrderStockHistoryResponse = [OrderStockHistoryResponseElement]


typealias stockHoldingsResponse = [StockHoldingsResponseElement]


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


struct CryptoResponse: Codable {
    let crypto: CryptoResponseElement?
    let info: CryptoInfoResponse?
    let usdQuote, cadQuote: CryptoQuoteResponse?
    let isInWatchlist, isInPortfolio: Bool?
}

// MARK: - Quote
struct CryptoQuoteResponse: Codable {
    let price, volume24H, percentChange1H, percentChange24H: Double?
    let percentChange7D, percentChange30D, percentChange60D, percentChange90D: Double?
    let marketCap: Double?

    enum CodingKeys: String, CodingKey {
        case price
        case volume24H = "volume24h"
        case percentChange1H = "percentChange1h"
        case percentChange24H = "percentChange24h"
        case percentChange7D = "percentChange7d"
        case percentChange30D = "percentChange30d"
        case percentChange60D = "percentChange60d"
        case percentChange90D = "percentChange90d"
        case marketCap
    }
}

// MARK: - Crypto
struct CryptoResponseElement: Codable{
    let id: Int
    let name, symbol, slug, dateAdded: String?
    let maxSupply: Double?
    let circulatingSupply: Double?
    let totalSupply: Double?
    let cmcRank: Int?
    let lastUpdated: String?
}

// MARK: - CryptoInfo
struct CryptoInfoResponse: Codable {
    let category, infoDescription: String?
    let logo: String?
    let website, twitter, reddit: String?

    enum CodingKeys: String, CodingKey {
        case category
        case infoDescription = "description"
        case logo, website, twitter, reddit
    }
}

struct CryptoSearchResponseElement: Codable {
    let id: Int
    let name, symbol, slug, dateAdded: String?
    let circulatingSupply, totalSupply: Double?
    let cmcRank: Int?
    let lastUpdated: String?
    let maxSupply: Int?
}

typealias CryptoSearchResponse = [CryptoSearchResponseElement]

struct CommonAPIResponse: Codable {
    let message: String
}
