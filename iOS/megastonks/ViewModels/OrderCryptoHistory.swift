//
//  OrderCryptoHistory.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-06-19.
//

import Foundation
struct OrderCryptoHistoryElement : Identifiable, Hashable {
    var id: UUID = UUID()
    var name, cryptoSymbol: String
    var logo: String
    var orderType, orderStatus, orderAction: String
    var quantitySubmitted, quantityFilled, commission: Double
    var pricePerShare, totalPriceFilled, totalCost: Double
    var forexExchangeRate, exchangeResult: Double
    var dateSubmitted, dateFilled: String

    init(orderResponse: OrderCryptoResponse) {
        self.name = orderResponse.name ?? ""
        self.cryptoSymbol = orderResponse.cryptoSymbol ?? ""
        self.logo = orderResponse.logo ?? ""
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

struct OrderCryptoHistory{
    var history: [OrderCryptoHistoryElement] = [OrderCryptoHistoryElement]()
    
    init(orderArray: OrderCryptoHistoryResponse){
        
        for order in orderArray{
            
            let orderToAdd = OrderCryptoHistoryElement(orderResponse: order)
            history.append(orderToAdd)
        }
        history.reverse()
    }
}

