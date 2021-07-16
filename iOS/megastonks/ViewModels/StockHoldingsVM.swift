//
//  StockHoldingsVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-07-15.
//

import Foundation

class StockHoldingsVM: ObservableObject {
    @Published var stockHoldings:StockHoldings
    
    init() {
        self.stockHoldings = StockHoldings(holdingsArray: [StockHoldingsResponseElement]())
    }
    
    func getStockHoldingsAsync() {
        var response = RequestResponse()
        API().GetAssetHoldings(isCrypto: false){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(stockHoldingsResponse.self, from: result.data!) {
                    response.stockHoldingsResponse = StockHoldings(holdingsArray: jsonResponse)
                    if(self.shouldStockholdingsUpdate(response.stockHoldingsResponse!, self.stockHoldings)){
                        DispatchQueue.main.async {
                            self.stockHoldings = response.stockHoldingsResponse!
                        }
                    }
                }
            }
        }
    }
    
    func getStockHoldings(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetHoldings(isCrypto: false){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(stockHoldingsResponse.self, from: result.data!) {
                    response.stockHoldingsResponse = StockHoldings(holdingsArray: jsonResponse)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    func getStockHolding(stockId: Int, completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetHolding(assetId: stockId, isCrypto: false){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(HoldingResponseInfoPage.self, from: result.data!) {
                    response.holdingInfoPageResponse = HoldingInfoPage(jsonResponse)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    private func shouldStockholdingsUpdate(_ incomingStockHoldings: StockHoldings, _ stockHoldings: StockHoldings) -> Bool{
        
        if(incomingStockHoldings.holdings.count != stockHoldings.holdings.count){
            return true
        }
        return false
    }
}
