//
//  CryptoHoldingsVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-07-15.
//

import Foundation

class CryptoHoldingsVM: ObservableObject {
    @Published var cryptoHoldings:CryptoHoldings
    
    init() {
        self.cryptoHoldings = CryptoHoldings(holdingsArray: [CryptoHoldingsResponseElement]())
    }
    
    
    func getCryptoHolding(cryptoId: Int, completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetHolding(assetId: cryptoId, isCrypto: true){ result in
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
    
    func getCryptoHoldingsAsync() {
        var response = RequestResponse()
        API().GetAssetHoldings(isCrypto: true){ result in
            response = result
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode([CryptoHoldingsResponseElement].self, from: result.data!) {
                    response.cryptoHoldingsResponse = CryptoHoldings(holdingsArray: jsonResponse)
                    if(self.shouldCryptoholdingsUpdate(response.cryptoHoldingsResponse!, self.cryptoHoldings)){
                        DispatchQueue.main.async {
                            self.cryptoHoldings = response.cryptoHoldingsResponse!
                        }
                    }
                }
            }
        }
    }
    
    func getCryptoHoldings(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetAssetHoldings(isCrypto: true){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode([CryptoHoldingsResponseElement].self, from: result.data!) {
                    response.cryptoHoldingsResponse = CryptoHoldings(holdingsArray: jsonResponse)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    private func shouldCryptoholdingsUpdate(_ incomingCryptoHoldings: CryptoHoldings, _ cryptoHoldings: CryptoHoldings) -> Bool{
        
        if(incomingCryptoHoldings.holdings.count != cryptoHoldings.holdings.count){
            return true
        }
        return false
    }
}
