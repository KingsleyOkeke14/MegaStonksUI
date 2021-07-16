//
//  AssetPortfolioPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-06-04.
//

import SwiftUI

struct AssetPortfolioPageView: View {
    
    @State var isAllTimeGains:Bool = true

    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var userWalletVM: UserWalletVM
    @EnvironmentObject var stockHoldingsVM: StockHoldingsVM
    @EnvironmentObject var cryptoHoldingsVM: CryptoHoldingsVM
    @EnvironmentObject var stockWatchListVM: StockWatchListVM
    @EnvironmentObject var cryptoWatchListVM: CryptoWatchListVM
    @EnvironmentObject var stockSearchResultVM: StockSearchResultVM
    @EnvironmentObject var cryptoSearchResultVM: CryptoSearchResultVM
    
        init() {
            let coloredAppearance = UINavigationBarAppearance()
    
            // this overrides everything you have set up earlier.
            coloredAppearance.configureWithTransparentBackground()
            coloredAppearance.backgroundColor = .black
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    
            // to make everything work normally
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    
            UINavigationBar.appearance().tintColor = .systemGray4
        }
    
    var body: some View {
        NavigationView{
            VStack{
                PortfolioSummaryView(isAllTimeGains: $isAllTimeGains)
                    .environmentObject(userWalletVM)
                    .environmentObject(userAuth)
                PageView(pages: [AssetPorfolioPage(isAllTimeGains: $isAllTimeGains)], currentPage: Binding.constant(0))
                    .padding(.top, 20)
                    .environmentObject(userAuth)
                    .environmentObject(userWalletVM)
                    .environmentObject(stockHoldingsVM)
                    .environmentObject(cryptoHoldingsVM)
                    .environmentObject(stockWatchListVM)
                    .environmentObject(cryptoWatchListVM)
                    .environmentObject(stockSearchResultVM)
                    .environmentObject(cryptoSearchResultVM)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AssetPortfolioPageView_Previews: PreviewProvider {
    static var previews: some View {
        AssetPortfolioPageView()
            .preferredColorScheme(.dark)
            .environmentObject(UserAuth())
            .environmentObject(UserWalletVM())
            .environmentObject(StockHoldingsVM())
            .environmentObject(CryptoHoldingsVM())
            .environmentObject(StockWatchListVM())
            .environmentObject(CryptoWatchListVM())
    }
}
