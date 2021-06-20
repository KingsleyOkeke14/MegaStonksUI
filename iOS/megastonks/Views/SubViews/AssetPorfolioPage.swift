//
//  PortfolioPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-10.
//

import SwiftUI

struct AssetPorfolioPage: View {
    
    let myColors = MyColors()
    
    @EnvironmentObject var myAppObjects:AppObjects
    @EnvironmentObject var userAuth: UserAuth
    
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
                
                if(!myAppObjects.stockHoldings.holdings.isEmpty || !myAppObjects.cryptoHoldings.holdings.isEmpty){
                    ScrollView{
                        VStack(spacing: 0) {
                            PullToRefreshView(onRefresh:{
                                isLoadingHoldings = true
                                myAppObjects.getWalletAsync()
                                myAppObjects.getStockHoldings(){
                                    result in
                                    if(result.isSuccessful){
                                        DispatchQueue.main.async {
                                            myAppObjects.stockHoldings = result.stockHoldingsResponse!
                                        }
                                    }
                                    isLoadingHoldings = false
                                }
                                myAppObjects.getCryptoHoldings(){
                                    result in
                                    if(result.isSuccessful){
                                        DispatchQueue.main.async {
                                            myAppObjects.cryptoHoldings = result.cryptoHoldingsResponse!
                                        }
                                    }
                                    isLoadingHoldings = false
                                }
                            })
                        }
                        LazyVStack {
                            if(!myAppObjects.stockHoldings.holdings.isEmpty){
                                ForEach(myAppObjects.stockHoldings.holdings, id: \.self){ holding in
                                    NavigationLink(
                                        destination: StocksInfoPageView(showOrderButtons: true, stockToSearch: holding.stockId, stock: nil)
                                            .onDisappear(perform: {
                                                myAppObjects.getStockHoldingsAsync()
                                                myAppObjects.updateStockWatchListAsync()
                                            })
                                            .environmentObject(myAppObjects)
                                            .environmentObject(userAuth)
                                        ,
                                        tag: holding.id.uuidString,
                                        selection: $selectedItem,
                                        label: {PortfolioStockSymbolView(holding: holding, isAllTimeGains: $isAllTimeGains)})
                                }
                            }
                            if(!myAppObjects.cryptoHoldings.holdings.isEmpty){
                                ForEach(myAppObjects.cryptoHoldings.holdings, id: \.self){ holding in
                                    NavigationLink(
                                        destination: CryptoInfoPageView(cryptoToSearch: holding.cryptoId, crypto: nil, cryptoQuote: nil)
                                            .onDisappear(perform: {
                                                myAppObjects.getCryptoHoldingsAsync()
                                                myAppObjects.updateCryptoWatchListAsync()
                                            })
                                            .environmentObject(myAppObjects)
                                            .environmentObject(userAuth)
                                        ,
                                        tag: holding.id.uuidString,
                                        selection: $selectedItem,
                                        label: {PortfolioCryptoSymbolView(holding: holding, isAllTimeGains: $isAllTimeGains)})
                                }
                            }
                        }.padding(.horizontal)
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
                Spacer()
            }
        }
        .onAppear(perform: {
                isLoadingHoldings = true
                myAppObjects.getWalletAsync()
                myAppObjects.getStockHoldings(){
                    result in
                    if(result.isSuccessful){
                        DispatchQueue.main.async {
                            myAppObjects.stockHoldings = result.stockHoldingsResponse!
                        }
                    }
                    isLoadingHoldings = false
                }
            myAppObjects.getCryptoHoldings(){
                result in
                if(result.isSuccessful){
                    DispatchQueue.main.async {
                        myAppObjects.cryptoHoldings = result.cryptoHoldingsResponse!
                    }
                }
                isLoadingHoldings = false
            }
        })
        .onDisappear(perform: {
            myAppObjects.getWalletAsync()
        })
    }
}

struct PortfolioPageView_Previews: PreviewProvider {
    static var previews: some View {
        AssetPorfolioPage(isAllTimeGains: Binding.constant(true))
            .preferredColorScheme(.dark)
            .environmentObject(AppObjects())
            .environmentObject(UserAuth())
        
    }
}
