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
        StockSearchResult(StockSearchElementResponse(id: 40, symbol: "AAPL", companyName: "Apple INC", marketCap: 100000, sector: "Tech", industry: "Tech", beta: 0, price: 220.246, lastAnnualDividend: 1, volume: 1, exchange: "", exchangeShortName: "NYSE", country: "CA", isEtf: false, isActivelyTrading: false, lastUpdated: ""))]
    
    var stockHolding:StockHolding = StockHolding(StockHoldingsResponseElement(id: 0, stockId: 122, symbol: "WELL", exchange: "DOC.V", changesPercentage: 10.0, averageCost: 20.0, quantity: 200, marketValue: 400.00, percentReturnToday: 2.00, moneyReturnToday: 12.0, percentReturnTotal: 10.0, moneyReturnTotal: 40.0, percentOfPortfolio: 20.0))
    
    var orderHistoryElement:OrderHistoryElement = OrderHistoryElement(OrderHistoryResponseElement(id: 0, symbol: "DOC", name: "CloudMD Health and Services Inc", orderType: "Market Order", orderStatus: "Executed", orderAction: "BUY", quantitySubmitted: 20.0, quantityFilled: 20.0, commission: 10.0, pricePerShare: 2.0, totalPriceFilled: 50.0, totalCost: 50.0, dateSubmitted: "Feb 8, 2020 11:40AM", dateFilled: "Feb 8, 2020 11:40AM"))
    
    
    var orderResult:OrderResultInfo = OrderResultInfo(orderResponse: OrderStockResponse(name: "CLOUDMD Health Services", stockSymbol: "DOC", currency: "CAD", orderType: "Market Order", orderStatus: "Executed", orderAction: "BUY", quantitySubmitted: 20.0, quantityFilled: 20.0, commission: 10.0, pricePerShare: 2.0, totalPriceFilled: 50.0, totalCost: 50.0, forexExchangeRate: 0.566668943485835680284354543245, exchangeResult: 2.005324954589447245234, dateSubmitted: "Feb 8, 2020 11:40AM", dateFilled: "Feb 8, 2020 11:40AM"))
    
    var adData:AdData = AdData([AdsResponseElement(id: 1, company: "", title: "Birken", adsResponseDescription: "This is the newest Birken Sandal. Get one for $100 now by clicking on this banner", imageURL: "https://megastonksadimages.blob.core.windows.net/adimages/birken.jpg", urlToLoad: "https://www.megastonks.com", dateAdded: "435345", expiryDate: "wefwfwf", lastUpdated: "fwewefwf")])
    
    var newsModel = NewsElement(NewsResponseElement(symbol: "TSLA", publishedDate: "", title: "FireEye Pops, Facebook Drops as Dow Eyes Record High", image: "https://cdn.snapi.dev/images/v1/v/z/aosk12wedf-1-811106.jpg", site: "Benzinga", text: "Amazon drivers are being told to turn off a mandatory safety app in order to hit their quotas, according to a new report from Vice. Vice obtained texts sent to drivers by Delivery Service Partners (DSPs) — companies which are contracted by Amazon to carry out its delivery operations. The texts told drivers to switch off the app Amazon uses to monitor safety, called \"Mentor.\"", url: "https://www.megastonks.ca"))
//        , AdsResponseElement(id: 1, company: "", title: "Birken", adsResponseDescription: "This is the newest Birken Sandal. Get one for $100 now by clicking on this banner", imageURL: "https://megastonksadimages.blob.core.windows.net/adimages/birken.jpg", urlToLoad: "https://www.megastonks.com", dateAdded: "435345", expiryDate: "wefwfwf", lastUpdated: "Kjkjnk")
    
    
//    title: "Birken", l: "", urlToLoad: "https://www.megastonks.com"), AdData(title: "H & M", description: "Get This at your Local Store now for only 40% Off. This deal expires soon so be sure to grab yours soon", imageUrl: "https://megastonksadimages.blob.core.windows.net/adimages/bubbles.jpg", urlToLoad: "https://www.megastonks.com"), AdData(title: "Rolex", description: "The new Rolex Alpha for only Alpha Males. Get one now at a 5% discount", imageUrl: "https://megastonksadimages.blob.core.windows.net/adimages/rolex.jpg", urlToLoad: "https://www.megastonks.com"), AdData(title: "Converse", description: "Convesrse All Star is back this summer. Get one now for only $200", imageUrl: "https://megastonksadimages.blob.core.windows.net/adimages/converse.jpg", urlToLoad: "https://www.megastonks.com"), AdData(title: "MegaStonks", description: "Become a sponsor for as low as $50/Day. Contact us sales@megastonks.com", imageUrl: "https://megastonksadimages.blob.core.windows.net/adimages/megastonks.jpg", urlToLoad: "https://www.megastonks.com")
    
     var data1D = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 6)]
   
    
    
}
