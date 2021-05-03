//
//  PortfolioPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-10.
//

import SwiftUI

struct PortfolioPageView: View {
    
    let myColors = MyColors()
    
    @EnvironmentObject var myAppObjects:AppObjects
    @EnvironmentObject var userAuth: UserAuth
    
    @State private var selectedItem: String?
    
    @State var isAllTimeGains:Bool = true
    
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
            Color.black
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                VStack(spacing: 20){
                    PortfolioSummaryView(isAllTimeGains: $isAllTimeGains)
                        .environmentObject(myAppObjects)
                        .environmentObject(userAuth)
                    HStack {
                        Text("Holdings")
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                .bold()
                                .foregroundColor(myColors.greenColor)
                        Spacer()
                    }.padding(.horizontal)
 
                    if(!myAppObjects.holdings.holdings.isEmpty){
                        ScrollView{
                            LazyVStack {
                                ForEach(myAppObjects.holdings.holdings, id: \.self){ holding in
                                    NavigationLink(
                                        destination: StocksInfoPageView2(stockToGet: StockSearchResult(StockSearchElementResponse(id: holding.stockId, symbol: "", companyName: "", marketCap: 0, sector: "", industry: "", beta: 2.0, price: 0.0, lastAnnualDividend: 0.0, volume: 0, exchange: "", exchangeShortName: "", country: "", isEtf: false, isActivelyTrading: false, lastUpdated: "")))
                                            .onDisappear(perform: {
                                                myAppObjects.getWalletAsync()
                                                myAppObjects.getStockHoldingsAsync()
                                            })
                                            .environmentObject(myAppObjects)
                                            .environmentObject(userAuth)
                                        ,
                                        tag: holding.id.uuidString,
                                        selection: $selectedItem,
                                        label: {PortfolioStockSymbolView(holding: holding, isAllTimeGains: $isAllTimeGains)})
                                }
                            }.padding(.horizontal)
                        }
                       
                    }
                    Spacer()
                }
                
            )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        
        
        }.onAppear(perform: {
            myAppObjects.getWalletAsync()
            myAppObjects.getStockHoldingsAsync()
        })
        .onDisappear(perform: {
            myAppObjects.updateWatchListAsync()
            myAppObjects.getStockHoldingsAsync()
        })
        .banner(data: $myAppObjects.bannerData, show: $myAppObjects.showBanner)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct PortfolioPageView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioPageView()
            .environmentObject(AppObjects())
            .environmentObject(UserAuth())
            
    }
}
