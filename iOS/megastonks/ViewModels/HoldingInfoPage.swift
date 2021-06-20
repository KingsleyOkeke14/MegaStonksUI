//
//  HoldingInfoPage.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-06-19.
//

import Foundation

struct HoldingInfoPage: Identifiable, Hashable{
    var id = UUID()
    var averageCost: Double?
    var quantity, marketValue: Double?
    var percentReturnToday, moneyReturnToday, percentReturnTotal: Double?
    var moneyReturnTotal: Double?
    var percentOfPortfolio: Double?
    var lastUpdated: String?
    
    init(_ assetElement:HoldingResponseInfoPage){
        averageCost = assetElement.averageCost ?? 0
        quantity = assetElement.quantity ?? 0.0
        marketValue = assetElement.marketValue ?? 0.0
        percentReturnToday = assetElement.percentReturnToday ?? 0
        moneyReturnToday = assetElement.moneyReturnToday ?? 0
        percentReturnTotal = assetElement.percentReturnTotal ?? 0
        moneyReturnTotal = assetElement.moneyReturnTotal ?? 0.0
        percentOfPortfolio = assetElement.percentOfPortfolio ?? 0
        lastUpdated = assetElement.lastUpdated ?? ""
    }
}
