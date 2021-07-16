//
//  CryptoHolding.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-06-19.
//

import Foundation
struct CryptoHolding : Identifiable, Hashable {
    var id:UUID = UUID()
    var cryptoId: Int
    var name, symbol: String
    var logo: String
    var averageCost, quantity, marketValue, percentReturnToday: Double
    var moneyReturnToday, percentReturnTotal, moneyReturnTotal, percentOfPortfolio: Double
    
    init(_ cryptoElement: CryptoHoldingsResponseElement) {
        cryptoId = cryptoElement.cryptoId!
        name = cryptoElement.name ?? ""
        symbol = cryptoElement.symbol ?? ""
        logo = cryptoElement.logo ?? ""
        averageCost = cryptoElement.averageCost ?? 0
        quantity = cryptoElement.quantity ?? 0.0
        marketValue = cryptoElement.marketValue ?? 0
        percentReturnToday = cryptoElement.percentReturnToday ?? 0
        moneyReturnToday = cryptoElement.moneyReturnToday ?? 0
        percentReturnTotal = cryptoElement.percentReturnTotal ?? 0
        moneyReturnTotal = cryptoElement.moneyReturnTotal ?? 0
        percentOfPortfolio = cryptoElement.percentOfPortfolio ?? 0
    }
}

struct CryptoHoldings{
    
    var holdings: [CryptoHolding] = [CryptoHolding]()
    
    init(holdingsArray:[CryptoHoldingsResponseElement]){
        
        for holding in holdingsArray{
            
            let holdingToAdd = CryptoHolding(holding)
            holdings.append(holdingToAdd)
        }
        holdings.reverse()
    }
}
