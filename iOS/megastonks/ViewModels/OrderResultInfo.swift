//
//  OrderResultInfo.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-03.
//

import Foundation

struct OrderResultInfo{
    var name, stockSymbol, currency, orderType: String
    var orderStatus, orderAction: String
    var quantitySubmitted, quantityFilled, commission: Double
    var pricePerShare, totalPriceFilled, totalCost, forexExchangeRate: Double
    var exchangeResult: Double
    var dateSubmitted, dateFilled: String
    
    init(orderResponse: OrderStockResponse){
        self.name = orderResponse.name ?? ""
        self.stockSymbol = orderResponse.stockSymbol ?? ""
        self.currency = orderResponse.currency ?? ""
        self.orderType = orderResponse.orderType ?? ""
        self.orderStatus = orderResponse.orderStatus ?? ""
        self.orderAction = orderResponse.orderAction ?? ""
        self.quantitySubmitted = orderResponse.quantitySubmitted ?? 0.0
        self.quantityFilled = orderResponse.quantityFilled ?? 0.0
        self.commission = orderResponse.commission ?? 0.0
        self.pricePerShare = orderResponse.pricePerShare ?? 0.0
        self.totalPriceFilled = orderResponse.totalPriceFilled ?? 0.0
        self.totalCost = orderResponse.totalCost ?? 0.0
        self.forexExchangeRate = orderResponse.forexExchangeRate ?? 0.0
        self.exchangeResult = orderResponse.exchangeResult ?? 0.0
        self.dateSubmitted = orderResponse.dateSubmitted ?? ""
        self.dateFilled = orderResponse.dateFilled ?? ""
    }
}

