//
//  StockSymbol.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-03.
//

import Foundation
struct StockSymbol: Identifiable{
    var id = UUID()
    var tickerSymbol:String
    var price:Double
    var exchange:String
    var percentChange:Double
    var dollarChange:Double
    var currency:String
    var isGaining:Bool
}
