//
//  PortfolioPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-10.
//

import SwiftUI

struct AssetPorfolioPage: View {
    
    let myColors = MyColors()
    
    
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var userWalletVM: UserWalletVM
    @EnvironmentObject var stockHoldingsVM: StockHoldingsVM
    @EnvironmentObject var cryptoHoldingsVM: CryptoHoldingsVM
    @EnvironmentObject var stockWatchListVM: StockWatchListVM
    @EnvironmentObject var cryptoWatchListVM: CryptoWatchListVM
    @EnvironmentObject var stockSearchResultVM: StockSearchResultVM
    @EnvironmentObject var cryptoSearchResultVM: CryptoSearchResultVM
    @EnvironmentObject var stockOrderVM: StockOrderVM
    @EnvironmentObject var cryptoOrderVM: CryptoOrderVM
    
    @State private var selectedItem: String?
    
    @Binding var isAllTimeGains:Bool
    
    @State var isLoadingHoldings:Bool = true
    
    
    var body: some View {
        VStack{
            VStack(spacing: 20){
                HStack {
                    Text("Holdings")
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                        .bold()
                        .foregroundColor(myColors.greenColor)
                    Spacer()
                        Button(action: {
                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                            impactMed.impactOccurred()
                            isAllTimeGains.toggle()
                            
                        }, label: {
                            Text(isAllTimeGains ? "All Time Return" : "Today's Return")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                                .bold()
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(myColors.grayColor)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        })
                    
                }.padding(.horizontal)
                    ScrollView{
                        VStack(spacing: 0) {
                            PullToRefreshView(onRefresh:{
                                isLoadingHoldings = true
                                userWalletVM.getWalletAsync()
                                stockHoldingsVM.getStockHoldings(){
                                    result in
                                    if(result.isSuccessful){
                                        DispatchQueue.main.async {
                                            stockHoldingsVM.stockHoldings = result.stockHoldingsResponse!
                                        }
                                    }
                                    isLoadingHoldings = false
                                }
                                cryptoHoldingsVM.getCryptoHoldings(){
                                    result in
                                    if(result.isSuccessful){
                                        DispatchQueue.main.async {
                                            cryptoHoldingsVM.cryptoHoldings = result.cryptoHoldingsResponse!
                                        }
                                    }
                                    isLoadingHoldings = false
                                }
                            })
                        }
                        if(!stockHoldingsVM.stockHoldings.holdings.isEmpty || !cryptoHoldingsVM.cryptoHoldings.holdings.isEmpty){
                        LazyVStack {
                            if(!stockHoldingsVM.stockHoldings.holdings.isEmpty){
                                ForEach(stockHoldingsVM.stockHoldings.holdings, id: \.self){ holding in
                                    NavigationLink(
                                        destination: StocksInfoPageView(showOrderButtons: true, stockToSearch: holding.stockId, stock: nil)
                                            .environmentObject(userAuth)
                                            .environmentObject(stockWatchListVM)
                                            .environmentObject(stockHoldingsVM)
                                            .environmentObject(stockSearchResultVM)
                                            .environmentObject(stockOrderVM)
                                            .environmentObject(userWalletVM)
                                            .onDisappear(perform: {
                                                stockHoldingsVM.getStockHoldingsAsync()
                                                stockWatchListVM.updateStockWatchListAsync()
                                            })
                                            .environmentObject(stockHoldingsVM)
                                            .environmentObject(userAuth)
                                        ,
                                        tag: holding.id.uuidString,
                                        selection: $selectedItem,
                                        label: {PortfolioStockSymbolView(holding: holding, isAllTimeGains: $isAllTimeGains)})
                                }
                            }
                            if(!cryptoHoldingsVM.cryptoHoldings.holdings.isEmpty){
                                ForEach(cryptoHoldingsVM.cryptoHoldings.holdings, id: \.self){ holding in
                                    NavigationLink(
                                        destination: CryptoInfoPageView(cryptoToSearch: holding.cryptoId, crypto: nil, cryptoQuote: nil)
                                            .environmentObject(userAuth)
                                            .environmentObject(cryptoWatchListVM)
                                            .environmentObject(cryptoSearchResultVM)
                                            .environmentObject(cryptoHoldingsVM)
                                            .environmentObject(cryptoOrderVM)
                                            .environmentObject(userWalletVM)
                                            .onDisappear(perform: {
                                                cryptoHoldingsVM.getCryptoHoldingsAsync()
                                                cryptoWatchListVM.updateCryptoWatchListAsync()
                                            })
                                            .environmentObject(cryptoHoldingsVM)
                                            .environmentObject(userAuth)
                                        ,
                                        tag: holding.id.uuidString,
                                        selection: $selectedItem,
                                        label: {PortfolioCryptoSymbolView(holding: holding, isAllTimeGains: $isAllTimeGains)})
                                }
                            }
                        }.padding(.horizontal)
                        }
                    }.overlay(
                        VStack{
                            if(isLoadingHoldings){
                                Color.black
                                    .overlay(
                                        ProgressView()
                                            .accentColor(.green)
                                            .scaleEffect(x: 1.4, y: 1.4)
                                            .progressViewStyle(CircularProgressViewStyle(tint: myColors.greenColor))
                                    )
                                
                            }
                        }
                    )
            }
        }
        .onAppear(perform: {
                isLoadingHoldings = true
                userWalletVM.getWalletAsync()
                stockHoldingsVM.getStockHoldings(){
                    result in
                    if(result.isSuccessful){
                        DispatchQueue.main.async {
                            stockHoldingsVM.stockHoldings = result.stockHoldingsResponse!
                        }
                    }
                    isLoadingHoldings = false
                }
            cryptoHoldingsVM.getCryptoHoldings(){
                result in
                if(result.isSuccessful){
                    DispatchQueue.main.async {
                        cryptoHoldingsVM.cryptoHoldings = result.cryptoHoldingsResponse!
                    }
                }
                isLoadingHoldings = false
            }
        })
        .onDisappear(perform: {
            userWalletVM.getWalletAsync()
        })
    }
}

struct PortfolioPageView_Previews: PreviewProvider {
    static var previews: some View {
        AssetPorfolioPage(isAllTimeGains: Binding.constant(true))
            .preferredColorScheme(.dark)
            .environmentObject(UserWalletVM())
            .environmentObject(UserAuth())
        
    }
}
