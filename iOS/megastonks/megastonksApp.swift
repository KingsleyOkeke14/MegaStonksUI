//
//  megastonksApp.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-01-31.
//

import SwiftUI

@main
struct megastonksApp: App {
    var body: some Scene {
        WindowGroup {
            let userAuth = UserAuth()
            RootPageView().environmentObject(userAuth)
            
      
            //RegisterPageView()
            //StockSymbolView(stock: StockSymbolModel().symbols[0])
            //WatchListPageView(searchText: "")
            //StocksInfoPageView()
            //ProfileSettingsPageView()
            //ProfilePageView()
            //RegisterPageView()
            //OnBoardPageView()
        //ButtonSelectionView()
            //RegisterPageView()
        }
    }
}
