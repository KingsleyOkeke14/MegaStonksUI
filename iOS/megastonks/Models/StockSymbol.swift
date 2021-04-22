//
//  StockSymbol.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-03.
//

import Foundation
struct StockSymbol: Identifiable, Hashable{
    var id = UUID()
    let stockId: Int
    let symbol, name, description: String
    let price: Double
    let currency: String
    let changesPercentage, change, dayLow, dayHigh: Double
    let yearHigh, yearLow: Double
    let marketCap: Int
    let priceAvg50, priceAvg200: Double
    let volume, avgVolume: Int
    let exchange: String
    let open, previousClose: Double
    let isInWatchList, isInPortfolio: Bool
    
    init(_ stockElement:StockElementResponse){
        stockId = stockElement.stockId
        symbol = stockElement.symbol
        name = stockElement.name
        description = stockElement.description
        price = stockElement.price
        currency = stockElement.currency
        changesPercentage = stockElement.changesPercentage
        change = stockElement.change
        dayLow = stockElement.dayLow
        dayHigh = stockElement.dayHigh
        yearHigh = stockElement.yearHigh
        yearLow = stockElement.yearLow
        marketCap = stockElement.marketCap
        priceAvg50 = stockElement.priceAvg50
        priceAvg200 = stockElement.priceAvg200
        volume = stockElement.volume
        avgVolume = stockElement.avgVolume
        exchange = stockElement.exchange
        open = stockElement.open
        previousClose = stockElement.previousClose
        isInWatchList = stockElement.isInWatchList
        isInPortfolio = stockElement.isInPortfolio
    }
}
