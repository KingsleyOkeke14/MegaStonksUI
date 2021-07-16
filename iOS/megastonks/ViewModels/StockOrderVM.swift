//
//  OrderStockHistoryVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-07-15.
//

import Foundation

class StockOrderVM: ObservableObject {
    
    @Published var orderStockHistory: OrderStockHistory
    
    init() {
        self.orderStockHistory = OrderStockHistory(orderArray: [OrderStockHistoryResponseElement]())
    }
    
    func getStockOrderHistoryAsync() {
        API().GetOrderHistory(isCrypto: false){ result in
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(OrderStockHistoryResponse.self, from: result.data!) {
                    if(jsonResponse.count != self.orderStockHistory.history.count){
                        DispatchQueue.main.async {
                            self.orderStockHistory  = OrderStockHistory(orderArray: jsonResponse)
                        }
                    }

                }
            }
        }
    }
    
    func orderStock(stockId:Int, orderType:String, orderAction:String, quantitySubmitted: Int, completion: @escaping (RequestResponse) -> ()){
        var response = RequestResponse()
        API().OrderStock(stockId: stockId, orderType: orderType, orderAction: orderAction, quantitySubmitted: quantitySubmitted){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                if let jsonResponse = try? decoder.decode(OrderStockResponse.self, from: result.data!) {
                    response.orderStockResponse = OrderStockResultInfo(orderResponse: jsonResponse)
                    response.isSuccessful = true
               }
            }
            completion(response)
        }
    }
    

}
