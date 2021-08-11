//
//  StockSearch.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-27.
//

import Foundation

struct StockSearchResult: Identifiable, Hashable{
    var id:UUID = UUID()
    var stockId:Int
    var symbol, companyName: String
    var marketCap: Int
    var sector, industry: String
    var beta, price, lastAnnualDividend: Double
    var volume: Int
    var exchange, exchangeShortName, country: String
    var isEtf, isActivelyTrading: Bool
    var lastUpdated: String
    
    init(_ stockElement:StockSearchElementResponse){
        stockId = stockElement.id
        symbol = stockElement.symbol ?? ""
        companyName = stockElement.companyName ?? ""
        marketCap = stockElement.marketCap ?? 0
        sector = stockElement.sector ?? ""
        industry = stockElement.industry ?? ""
        beta = stockElement.beta ?? 0
        price = stockElement.price ?? 0
        lastAnnualDividend = stockElement.lastAnnualDividend ?? 0
        volume = stockElement.volume ?? 0
        exchange = stockElement.exchange ?? ""
        exchangeShortName = stockElement.exchangeShortName ?? ""
        country = stockElement.country ?? ""
        isEtf = stockElement.isEtf ?? false
        isActivelyTrading = stockElement.isActivelyTrading ?? false
        lastUpdated = stockElement.lastUpdated ?? ""
    }
}

struct StockSearchResults{
    
    var stocks: [StockSearchResult] = [StockSearchResult]()
    
    init(stockElementArray:[StockSearchElementResponse]){
        
        for stock in stockElementArray{
            
            let stockToAdd = StockSearchResult(stock)
            stocks.append(stockToAdd)
        }
    }
}
