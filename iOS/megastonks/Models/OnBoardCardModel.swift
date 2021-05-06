//
//  OnBoardModel.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-01.
//

import Foundation
struct OnBoardCardModel{
    
    var cards:[OnBoardCard] = [
        OnBoardCard(image: "figure.wave", title: "Welcome to MegaStonks", description: "The app is designed to give you access and exposure to financial information on stocks and etfs which will allow you practice and refine your investment and trading strategies"),
        OnBoardCard(image: "chart.bar.xaxis", title: "Stonks", description: "Please note that at this time, we do not track dividend payments and stock splits. however, these features are currently in development"),
        OnBoardCard(image: "banknote.fill", title: "Portfolio", description: "Buy and sell securities at real time market prices, track your portfolio gains in real time and monitor your asset allocation")
        
    ]
}
