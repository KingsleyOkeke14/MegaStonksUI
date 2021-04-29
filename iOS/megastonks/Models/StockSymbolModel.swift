//
//  StockSymbolModel.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-03.
//

import Foundation
struct StockSymbolModel{
    var symbols:[StockSymbol] = [
        
        StockSymbol(StockElementResponse( stockId: 12, symbol: "DOC", name: "CloudMD Services", description: "Test", price: 20.2, currency: "CAD", changesPercentage: 0, change: 0, dayLow: 18, dayHigh: 22, yearHigh: 28, yearLow: 8, marketCap: 10000000000, priceAvg50: 20, priceAvg200: 22, volume: 2000000, avgVolume: 400000000, exchange: "TSXV", open: 20, previousClose: 0, isInWatchList: true, isInPortfolio: true)),
        
        StockSymbol(StockElementResponse(stockId: 14, symbol: "TSLA", name: "Tesla Inc", description: "Test", price: 200.0, currency: "USD", changesPercentage: -10, change: -100, dayLow: 18, dayHigh: 22, yearHigh: 28, yearLow: 8, marketCap: 1000000, priceAvg50: 20, priceAvg200: 22, volume: 2000000, avgVolume: 400000000, exchange: "NASDAQ", open: 220, previousClose: 0, isInWatchList: true, isInPortfolio: true)),
        
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
    
    var stockSearch:[StockSearchResult] = [
        StockSearchResult(StockSearchElementResponse(id: 20, symbol: "DOC", companyName: "Document Tracking", marketCap: 100000, sector: "Pharma", industry: "WEst", beta: 0, price: 20.000, lastAnnualDividend: 1, volume: 1, exchange: "", exchangeShortName: "TSX-V", country: "US", isEtf: false, isActivelyTrading: false, lastUpdated: "")),
        StockSearchResult(StockSearchElementResponse(id: 40, symbol: "AAPL", companyName: "Apple INC", marketCap: 100000, sector: "Tech", industry: "Tech", beta: 0, price: 220.246, lastAnnualDividend: 1, volume: 1, exchange: "", exchangeShortName: "NYSE", country: "CA", isEtf: false, isActivelyTrading: false, lastUpdated: ""))
    
    
    ]
    
     var data1D = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 6)]
    
     var data5D = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 38.0)]
    
     var data1M = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 38.0)]
    
     var data3M = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 38.0)]
    
     var data1Y = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 38.0)]
    
     var data5Y = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 38.0)]
    
}
