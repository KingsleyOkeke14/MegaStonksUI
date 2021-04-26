//
//  StockSymbol.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-03.
//

import Foundation
struct StockSymbol: Identifiable, Hashable{
    var id:UUID = UUID()
    var stockId: Int
    var symbol, name, description: String
    var price: Double
    var currency: String
    var changesPercentage, change, dayLow, dayHigh: Double
    var yearHigh, yearLow: Double
    var marketCap: Int
    var priceAvg50, priceAvg200: Double
    var volume, avgVolume: Int
    var exchange: String
    var open, previousClose: Double
    var isInWatchList, isInPortfolio: Bool
    
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

struct StockSymbols{
    
    var stocks: [StockSymbol] = [StockSymbol]()
    
    init(stockElementArray:[StockElementResponse]){
        
        for stock in stockElementArray{
            
            let stockToAdd = StockSymbol(stock)
            stocks.append(stockToAdd)
        }
    }
}
