//
//  OnBoardModel.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-01.
//

import Foundation
struct OnBoardCardModel{
    
    var cards:[OnBoardCard] = [
        OnBoardCard(image: "figure.wave", title: "Welcome to MegaStonks", description: "The app is designed to give you access and exposure to financial information on public US and Canadian securities. We hope you will be able to refine your investment and trading strategies by trading available stocks and etfs"),
        OnBoardCard(image: "chart.bar.xaxis", title: "Stonks", description: "You are allowed to trade assets 24/7. However, please note that you will not have access to pre or after market prices. Also, at this time, we do not track dividend payments and stock splits"),
        OnBoardCard(image: "banknote.fill", title: "Portfolio", description: "Buy and sell securities at real time market prices, track your portfolio gains in real time and monitor your asset allocation in your Wallet. Goodluck and dont blow up all your fun coupons 💸")
        
    ]
}
