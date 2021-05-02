//
//  UserWallet.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-01.
//

import Foundation

struct UserWallet{
    var firstName, lastName: String
    var cash, initialDeposit, investments, total: Double
    var percentReturnToday, moneyReturnToday, percentReturnTotal, moneyReturnTotal: Double
    var cashPercentage:Double
    
    init(_ walletResponse: WalletResponse) {
        firstName = walletResponse.firstName ?? ""
        lastName = walletResponse.lastName ?? ""
        cash = walletResponse.cash ?? 0.0
        initialDeposit = walletResponse.initialDeposit ?? 0.0
        investments = walletResponse.investments ?? 0.0
        total = walletResponse.total ?? 0.0
        percentReturnToday = walletResponse.percentReturnToday ?? 0.0
        moneyReturnToday = walletResponse.moneyReturnToday ?? 0.0
        percentReturnTotal = walletResponse.percentReturnTotal ?? 0.0
        moneyReturnTotal = walletResponse.moneyReturnTotal ?? 0.0
        cashPercentage = (walletResponse.cash ?? 0) / (walletResponse.total ?? 1)
    }
}
