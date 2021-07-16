//
//  CryptoOrdersVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-07-15.
//

import Foundation

class CryptoOrderVM: ObservableObject {
    @Published var orderCryptoHistory: OrderCryptoHistory
    
    init() {
        self.orderCryptoHistory = OrderCryptoHistory(orderArray: [OrderCryptoResponse]())
    }
    
    func getCryptoOrderHistoryAsync() {
        API().GetOrderHistory(isCrypto: true){ result in
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(OrderCryptoHistoryResponse.self, from: result.data!) {
                    if(jsonResponse.count != self.orderCryptoHistory.history.count){
                        DispatchQueue.main.async {
                            self.orderCryptoHistory  = OrderCryptoHistory(orderArray: jsonResponse)
                        }
                    }

                }
            }
        }
    }
    
    func orderCrypto(cryptoId:Int, orderType:String, orderAction:String, quantitySubmitted: Double, completion: @escaping (RequestResponse) -> ()){
        var response = RequestResponse()
        API().OrderCrypto(cryptoId: cryptoId, orderType: orderType, orderAction: orderAction, quantitySubmitted: quantitySubmitted){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                if let jsonResponse = try? decoder.decode(OrderCryptoResponse.self, from: result.data!) {
                    response.orderCryptoResponse = OrderCryptoResultInfo(orderResponse: jsonResponse)
                    response.isSuccessful = true
               }
            }
            completion(response)
        }
    }
}
