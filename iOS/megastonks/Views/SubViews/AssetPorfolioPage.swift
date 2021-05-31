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
    
    @State var isAllTimeGains:Bool = true
    
    @State var isLoadingHoldings:Bool = true
    
    
    
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
                            VStack(spacing: 0) {
                                PullToRefreshView(onRefresh:{
                                    isLoadingHoldings = true
                                    myAppObjects.getWalletAsync()
                                    myAppObjects.getStockHoldings(){
                                        result in
                                        if(result.isSuccessful){
                                            DispatchQueue.main.async {
                                                myAppObjects.holdings = result.stockHoldingsResponse!
                                            }
                                            isLoadingHoldings = false
                                        }
                                    }
                                })
                            }
                            LazyVStack {
                                ForEach(myAppObjects.holdings.holdings, id: \.self){ holding in
                                    NavigationLink(
                                        destination: StocksInfoPageView2(stockToGet: StockSearchResult(StockSearchElementResponse(id: holding.stockId, symbol: "", companyName: "", marketCap: 0, sector: "", industry: "", beta: 2.0, price: 0.0, lastAnnualDividend: 0.0, volume: 0, exchange: "", exchangeShortName: "", country: "", isEtf: false, isActivelyTrading: false, lastUpdated: "")), showOrderButtons: false, showWatchListButton: true )
                                            .onDisappear(perform: {
                                                myAppObjects.updateStockWatchListAsync()
                                            })
                                            .environmentObject(myAppObjects)
                                            .environmentObject(userAuth)
                                        ,
                                        tag: holding.id.uuidString,
                                        selection: $selectedItem,
                                        label: {PortfolioStockSymbolView(holding: holding, isAllTimeGains: $isAllTimeGains)})
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
                
            )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        
        
        }.onAppear(perform: {
            isLoadingHoldings = true
            myAppObjects.getWalletAsync()
            myAppObjects.getStockHoldings(){
                result in
                if(result.isSuccessful){
                    DispatchQueue.main.async {
                        myAppObjects.holdings = result.stockHoldingsResponse!
                    }
                    isLoadingHoldings = false
                }
            }
        })
        .onDisappear(perform: {
            myAppObjects.getWalletAsync()
        })
        .banner(data: $myAppObjects.bannerData, show: $myAppObjects.showBanner)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct PortfolioPageView_Previews: PreviewProvider {
    static var previews: some View {
        AssetPorfolioPage()
            .environmentObject(AppObjects())
            .environmentObject(UserAuth())
            
    }
}
