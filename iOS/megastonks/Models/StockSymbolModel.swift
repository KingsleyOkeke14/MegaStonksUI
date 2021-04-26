//
//  StockSymbolModel.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-03.
//

import Foundation
struct StockSymbolModel{
    var symbols:[StockSymbol] = [
        
        StockSymbol(StockElementResponse( stockId: 12, symbol: "DOC", name: "CloudMD Services", description: "Test", price: 20.2, currency: "CAD", changesPercentage: 0, change: 0, dayLow: 18, dayHigh: 22, yearHigh: 28, yearLow: 8, marketCap: 1000000, priceAvg50: 20, priceAvg200: 22, volume: 2000000, avgVolume: 400000000, exchange: "TSXV", open: 20, previousClose: 0, isInWatchList: true, isInPortfolio: true)),
        
        StockSymbol(StockElementResponse(stockId: 14, symbol: "TSLA", name: "Tesla Inc", description: "Test", price: 200.0, currency: "USD", changesPercentage: 10, change: 100, dayLow: 18, dayHigh: 22, yearHigh: 28, yearLow: 8, marketCap: 1000000, priceAvg50: 20, priceAvg200: 22, volume: 2000000, avgVolume: 400000000, exchange: "NASDAQ", open: 220, previousClose: 0, isInWatchList: true, isInPortfolio: false)),
        
//        StockSymbol(StockElementResponse(stockId: 18, symbol: "AAPL", name: "Apple Inc", description: "Apple Products", price: 134, currency: "USD", changesPercentage: 10, change: 10, dayLow: 18, dayHigh: 22, yearHigh: 28, yearLow: 8, marketCap: 1000000, priceAvg50: 20, priceAvg200: 22, volume: 2000000, avgVolume: 400000000, exchange: "TSXV", open: 20, previousClose: 0, isInWatchList: true, isInPortfolio: false)),
//        
//        StockSymbol(StockElementResponse(stockId: 12, symbol: "BRK.A", name: "Berkshire Hathaway", description: "Test", price: 123000, currency: "USD", changesPercentage: -10, change: -12000, dayLow: 18, dayHigh: 22, yearHigh: 28, yearLow: 8, marketCap: 1000000, priceAvg50: 20, priceAvg200: 22, volume: 2000000, avgVolume: 400000000, exchange: "NYSE", open: 20, previousClose: 0, isInWatchList: true, isInPortfolio: false)),
//        
//        StockSymbol(StockElementResponse(stockId: 12, symbol: "WELL", name: "Well Health Technologies", description: "Test", price: 7.90, currency: "CAD", changesPercentage: -20, change: -3.2, dayLow: 18, dayHigh: 22, yearHigh: 28, yearLow: 8, marketCap: 1000000, priceAvg50: 20, priceAvg200: 22, volume: 2000000, avgVolume: 400000000, exchange: "TSX", open: 20, previousClose: 0, isInWatchList: true, isInPortfolio: false)),
//        
//        StockSymbol(StockElementResponse(stockId: 18, symbol: "AAPL", name: "Apple Inc", description: "Apple Products", price: 134, currency: "USD", changesPercentage: 10, change: 10, dayLow: 18, dayHigh: 22, yearHigh: 28, yearLow: 8, marketCap: 1000000, priceAvg50: 20, priceAvg200: 22, volume: 2000000, avgVolume: 400000000, exchange: "TSXV", open: 20, previousClose: 0, isInWatchList: true, isInPortfolio: false)),
//        
//        StockSymbol(StockElementResponse(stockId: 12, symbol: "BRK.A", name: "Berkshire Hathaway", description: "Test", price: 123000, currency: "USD", changesPercentage: -10, change: -12000, dayLow: 18, dayHigh: 22, yearHigh: 28, yearLow: 8, marketCap: 1000000, priceAvg50: 20, priceAvg200: 22, volume: 2000000, avgVolume: 400000000, exchange: "NYSE", open: 20, previousClose: 0, isInWatchList: true, isInPortfolio: false)),
//        
//        StockSymbol(StockElementResponse(stockId: 12, symbol: "DOC", name: "CloudMD Services", description: "Test", price: 20.0, currency: "CAD", changesPercentage: -10, change: -100, dayLow: 18, dayHigh: 22, yearHigh: 28, yearLow: 8, marketCap: 1000000, priceAvg50: 20, priceAvg200: 22, volume: 2000000, avgVolume: 400000000, exchange: "TSXV", open: 20, previousClose: 0, isInWatchList: true, isInPortfolio: false)),
//        
//        StockSymbol(StockElementResponse(stockId: 14, symbol: "TSLA", name: "Tesla Inc", description: "Test", price: 200.0, currency: "USD", changesPercentage: 10, change: 100, dayLow: 18, dayHigh: 22, yearHigh: 28, yearLow: 8, marketCap: 1000000, priceAvg50: 20, priceAvg200: 22, volume: 2000000, avgVolume: 400000000, exchange: "NASDAQ", open: 220, previousClose: 0, isInWatchList: true, isInPortfolio: false))
    ]
    
}
