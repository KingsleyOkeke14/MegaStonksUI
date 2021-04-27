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
        symbol = stockElement.symbol ?? ""
        name = stockElement.name ?? ""
        description = stockElement.description ?? ""
        price = stockElement.price ?? 0
        currency = stockElement.currency ?? ""
        changesPercentage = stockElement.changesPercentage ?? 0
        change = stockElement.change ?? 0
        dayLow = stockElement.dayLow ?? 0
        dayHigh = stockElement.dayHigh ?? 0
        yearHigh = stockElement.yearHigh ?? 0
        yearLow = stockElement.yearLow ?? 0
        marketCap = stockElement.marketCap ?? 0
        priceAvg50 = stockElement.priceAvg50 ?? 0
        priceAvg200 = stockElement.priceAvg200 ?? 0
        volume = stockElement.volume ?? 0
        avgVolume = stockElement.avgVolume ?? 0
        exchange = stockElement.exchange ?? ""
        open = stockElement.open ?? 0
        previousClose = stockElement.previousClose ?? 0
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
