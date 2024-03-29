//
//  StockHolding.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-28.
//

import Foundation

struct StockHolding: Identifiable, Hashable{
    var id = UUID()
    var stockId: Int
    var symbol, exchange: String
    var changesPercentage, averageCost: Double
    var quantity: Double
    var marketValue, percentReturnToday, moneyReturnToday, percentReturnTotal: Double
    var moneyReturnTotal, percentOfPortfolio: Double
    
    init(_ stockElement:StockHoldingsResponseElement){
        stockId = stockElement.stockId
        symbol = stockElement.symbol ?? ""
        exchange = stockElement.exchange ?? ""
        changesPercentage = stockElement.changesPercentage ?? 0
        averageCost = stockElement.averageCost ?? 0
        quantity = stockElement.quantity ?? 0.0
        marketValue = stockElement.marketValue ?? 0
        percentReturnToday = stockElement.percentReturnToday ?? 0
        moneyReturnToday = stockElement.moneyReturnToday ?? 0
        percentReturnTotal = stockElement.percentReturnTotal ?? 0
        moneyReturnTotal = stockElement.moneyReturnTotal ?? 0
        percentOfPortfolio = stockElement.percentOfPortfolio ?? 0
    }
}

struct StockHoldings{
    
    var holdings: [StockHolding] = [StockHolding]()
    
    init(holdingsArray:[StockHoldingsResponseElement]){
        
        for holding in holdingsArray{
            
            let holdingToAdd = StockHolding(holding)
            holdings.append(holdingToAdd)
        }
        holdings.reverse()
    }
}


