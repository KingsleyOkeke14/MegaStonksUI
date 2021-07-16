//
//  AppPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-12.
//

import SwiftUI

struct AppPageView: View {
    @State private var selection = 0
    
    @EnvironmentObject var userAuth: UserAuth
    
    @StateObject var stockWatchListVM: StockWatchListVM = StockWatchListVM()
    @StateObject var cryptoWatchListVM: CryptoWatchListVM = CryptoWatchListVM()
    @StateObject var stockSearchResultVM: StockSearchResultVM = StockSearchResultVM()
    @StateObject var cryptoSearchResultVM: CryptoSearchResultVM = CryptoSearchResultVM()
    @StateObject var userWalletVM: UserWalletVM = UserWalletVM()
    @StateObject var stockHoldingsVM: StockHoldingsVM = StockHoldingsVM()
    @StateObject var cryptoHoldingsVM: CryptoHoldingsVM = CryptoHoldingsVM()
    @StateObject var stockOrderVM: StockOrderVM = StockOrderVM()
    @StateObject var cryptoOrderVM: CryptoOrderVM = CryptoOrderVM()
    @StateObject var adsVM: AdsVM = AdsVM()
    @StateObject var newsVM: NewsVM = NewsVM()
    
    
    var notificationManager = LocalNotificationManager()
    
    let myColors = MyColors()
    
    var body: some View {
        VStack {
            
            if(userAuth.user.isOnBoarded){
                TabView(selection: $selection) {
                    
                    WatchListPageView()
                        .tabItem {
                            Label("WatchList", systemImage: "eye")
                        }.tag(0)
                        .preferredColorScheme(.dark)
                        .environmentObject(stockWatchListVM)
                        .environmentObject(stockHoldingsVM)
                        .environmentObject(stockSearchResultVM)
                        .environmentObject(userWalletVM)
                        .environmentObject(stockOrderVM)
                        .environmentObject(cryptoWatchListVM)
                        .environmentObject(cryptoHoldingsVM)
                        .environmentObject(cryptoSearchResultVM)
                        .environmentObject(cryptoOrderVM)
                    NewsPageView()
                        .environmentObject(newsVM)
                        .environmentObject(adsVM)
                        .tabItem {
                            Label("News Feed", systemImage: selection == 1 ? "newspaper.fill" : "newspaper")
                        }.tag(1)
                        .preferredColorScheme(.dark)
                    
                    AssetPortfolioPageView()
                        .environmentObject(userAuth)
                        .environmentObject(userWalletVM)
                        .environmentObject(stockHoldingsVM)
                        .environmentObject(stockOrderVM)
                        .environmentObject(cryptoHoldingsVM)
                        .environmentObject(stockWatchListVM)
                        .environmentObject(cryptoWatchListVM)
                        .environmentObject(cryptoOrderVM)
                        .environmentObject(stockSearchResultVM)
                        .environmentObject(cryptoSearchResultVM)
                        
                        .tabItem {
                            Label("Portfolio", systemImage: selection == 2 ? "banknote.fill" : "banknote")
                        }.tag(2)
                        .preferredColorScheme(.dark)
                    
                    ProfilePageView()
                        .environmentObject(userAuth)
                        .environmentObject(userWalletVM)
                        .environmentObject(stockOrderVM)
                        .environmentObject(cryptoOrderVM)
                        .environmentObject(adsVM)
                        .tabItem {
                            Label("Account", systemImage: selection == 3 ? "person.fill" : "person")
                        }.tag(3)
                        .preferredColorScheme(.dark)
                }
                .animation(Animation.default)
                .accentColor(myColors.greenColor)
                .onAppear() {
                    UITabBar.appearance().shadowImage = UIImage()
                    UITabBar.appearance().backgroundImage = UIImage()
                    UITabBar.appearance().isTranslucent = true
                    UITabBar.appearance().backgroundColor = .black
                    UITabBar.appearance().unselectedItemTintColor = UIColor(myColors.greenColor.opacity(0.6))

                    
                }
            }
            else{
                OnBoardPageView()
            }
            
        }
    }
    
}

struct AppPageView_Previews: PreviewProvider {
    static var previews: some View {
        AppPageView().environmentObject(UserAuth())
            .environmentObject(CryptoWatchListVM())
            .environmentObject(StockSearchResultVM())
            .environmentObject(StockWatchListVM())
            .environmentObject(CryptoSearchResultVM())
            .environmentObject(UserWalletVM())
            .environmentObject(StockHoldingsVM())
            .environmentObject(CryptoHoldingsVM())
            .environmentObject(StockOrderVM())
            .environmentObject(CryptoOrderVM())
            .environmentObject(AdsVM())
            .environmentObject(NewsVM())
    }
}
