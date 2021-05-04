//
//  OrderHistory.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-03.
//

import Foundation

struct OrderHistoryElement: Identifiable, Hashable{
    var id: UUID = UUID()
    var symbol: String
    var name: String
    var orderType: String
    var orderStatus: String
    var orderAction: String
    var quantitySubmitted, quantityFilled, commission: Double
    var pricePerShare, totalPriceFilled, totalCost: Double
    var dateSubmitted, dateFilled: String
    
    init(_ orderHistoryElement: OrderHistoryResponseElement) {
        self.symbol = orderHistoryElement.symbol ?? ""
        self.name = orderHistoryElement.name ?? ""
        self.orderType = orderHistoryElement.orderType ?? ""
        self.orderStatus = orderHistoryElement.orderStatus ?? ""
        self.orderAction = orderHistoryElement.orderAction ?? ""
        self.quantitySubmitted = orderHistoryElement.quantitySubmitted ?? 0.0
        self.quantityFilled = orderHistoryElement.quantityFilled ?? 0.0
        self.commission = orderHistoryElement.commission ?? 0.0
        self.pricePerShare = orderHistoryElement.pricePerShare ?? 0.0
        self.totalPriceFilled = orderHistoryElement.totalPriceFilled ?? 0.0
        self.totalCost = orderHistoryElement.totalCost ?? 0.0
        self.dateSubmitted = orderHistoryElement.dateSubmitted ?? ""
        self.dateFilled = orderHistoryElement.dateFilled ?? ""
    }
}

struct OrderHistory{
    var history: [OrderHistoryElement] = [OrderHistoryElement]()
    
    init(orderArray:[OrderHistoryResponseElement]){
        
        for order in orderArray{
            
            let orderToAdd = OrderHistoryElement(order)
            history.append(orderToAdd)
        }
        history.reverse()
        
    }
}
