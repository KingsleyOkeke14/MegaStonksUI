//
//  UserWalletVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-07-15.
//

import Foundation

class UserWalletVM: ObservableObject {
    @Published var userWallet:UserWallet
    
    init() {
        self.userWallet = UserWallet(WalletResponse(firstName: "", lastName: "", cash: 0.0, initialDeposit: 0.0, investments: 0.0, total: 0.0, percentReturnToday: 0.0, moneyReturnToday: 0.0, percentReturnTotal: 0.0, moneyReturnTotal: 0.0))
        
        
    }
    
    func getWallet(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetWallet(){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(WalletResponse.self, from: result.data!) {
                    response.walletResponse  = UserWallet(jsonResponse)
                    response.isSuccessful = true
                }
            }
            completion(response)
        }
    }
    
    func getWalletAsync() {
        API().GetWallet(){ result in
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(WalletResponse.self, from: result.data!) {
                    DispatchQueue.main.async {
                        self.userWallet  = UserWallet(jsonResponse)
                    }
                }
            }
        }
    }
    
    
    
}
