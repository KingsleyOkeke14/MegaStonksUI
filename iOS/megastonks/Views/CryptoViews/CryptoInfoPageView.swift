//
//  CryptoInfoPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-28.
//

import SwiftUI

struct CryptoInfoPageView: View {

    
    let myColors = MyColors()
    
    var cryptoQuote:CryptoQuote
    
    @State var isInWatchList:Bool
    @State var cryptoSymbol:CryptoSymbol
    @State var themeColor:Color
    
    
    @State var buttonList: [(buttonName: String, buttonState: Bool)] = [("1D", true), ("5D", false), ("10D", false), ("15D", false), ("30D", false)]
    
    @State var stockHolding:StockHoldingInfoPage
    
    @State var chartData = [(String, Double)]()
    
    @State var chartDiscrepancy = ""
    
    @State var chartPeriod = ""
    
    @State var isStockGaining:Bool = false
    
    @State var showingOrderPage:Bool = false
    
    @State var orderAction:String = ""
    
    
    
    @EnvironmentObject var myAppObjects:AppObjects
    @EnvironmentObject var userAuth: UserAuth
    

    init(crypto: CryptoSymbol, cryptoQuote: CryptoQuote) {
        self.cryptoQuote = cryptoQuote
        _isInWatchList = State(initialValue: crypto.isInWatchlist)
        _cryptoSymbol = State(initialValue: crypto)
        _themeColor = State(initialValue: (cryptoQuote.percentChange24H >= 0) ? Color.green : Color.red )
        _stockHolding = State.init( initialValue: StockHoldingInfoPage(HoldingResponseInfoPage(id: 0, averageCost: 0, quantity: 0, marketValue: 0, percentReturnToday: 0, moneyReturnToday: 0, percentReturnTotal: 0, moneyReturnTotal: 0, percentOfPortfolio: 0, lastUpdated: "")))
    }
    
    func changeActiveButton(activeButton: Int){
        
        for index in 0..<buttonList.count{
            buttonList[index].buttonState = false
        }
        buttonList[activeButton].buttonState = true
    }
    
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack{
                    if(!cryptoSymbol.crypto.name.isEmpty){
                        VStack(spacing: 2){
                            HStack {
                                Spacer()
                                Button(action: {
                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                    impactMed.impactOccurred()
                                    if(isInWatchList){
                                        myAppObjects.removeCryptoFromWatchListAsync(cryptoToRemove: cryptoSymbol.crypto.cryptoId)
                                    }
                                    else{
                                        myAppObjects.addCryptoToWatchListAsync(cryptoToAdd: cryptoSymbol.crypto.cryptoId)
                                    }
                                    isInWatchList.toggle()
                                }, label: {
                                    HStack{
                                        if(isInWatchList){
                                            Image(systemName: "eye")
                                                .foregroundColor(themeColor)
                                                .font(.custom("", fixedSize: 18))
                                                .padding(.trailing, 10)
                                            
                                        }
                                        else{
                                            Image(systemName: "eye.slash")
                                                .foregroundColor(themeColor)
                                                .font(.custom("", fixedSize: 18))
                                                .padding(.trailing, 10)
                                        }
                                    }
                                })
                            }
                            
                            CryptoInfoView(defaultCurrency: userAuth.user.currency, cryptoSymbol: $cryptoSymbol, highlightColor: $themeColor)
                            ScrollView{
                                VStack(spacing: 12){
                                    ChartView(isStockGaining: $isStockGaining, themeColor: $themeColor, data: $chartData, chartDiscrepancy: $chartDiscrepancy, chartLabel: $chartPeriod)
                                    
                                    HStack(spacing: 12){
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 0)
//                                            myAppObjects.getPriceChart(stockId: cryptoSymbol.stockId, isPriceHistory: false){
//                                                result in
//                                                if(result.isSuccessful){
//                                                    chartData = result.stockChartDataResponse!.dataSet
//                                                    chartDiscrepancy = String(cryptoSymbol.change.formatPrice() + "  (" + cryptoSymbol.changesPercentage.formatPercentChange() + "%)")
//                                                    chartPeriod = "Today"
//                                                    themeColor = (cryptoSymbol.change >= 0) ? Color.green : Color.red
//                                                    isStockGaining = (cryptoSymbol.change >= 0) ? true : false
//                                                }
//                                                else{
//                                                    chartData = [(String, Double)]()
//                                                }
//                                            }
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[0].buttonName, buttonSelected: buttonList[0].buttonState, buttonColor: $themeColor)
                                            
                                        })
                                        Button(action: {
                                            changeActiveButton(activeButton: 1)
//                                            myAppObjects.getPriceChart(stockId: cryptoSymbol.stockId, interval: buttonList[1].buttonName){
//                                                result in
//                                                if(result.isSuccessful){
//                                                    chartData = result.stockChartDataResponse!.dataSet
//                                                    let dataSet = result.stockChartDataResponse!.dataSet.map({$0.1})
//                                                    let discrepancy:Double = (dataSet.last! - dataSet[0])
//                                                    let percentChange = (discrepancy / dataSet.last! * 100)
//                                                    chartDiscrepancy = String(discrepancy.formatPrice() + "  (" + percentChange.formatPercentChange() + "%)")
//                                                    chartPeriod = "5 Days"
//                                                    themeColor = (percentChange >= 0) ? Color.green : Color.red
//                                                    isStockGaining = (percentChange >= 0) ? true : false
//                                                }
//                                                else{
//                                                    chartData = [(String, Double)]()
//                                                }
//                                            }
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[1].buttonName, buttonSelected: buttonList[1].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 2)
//                                            myAppObjects.getPriceChart(stockId: cryptoSymbol.stockId, interval: buttonList[2].buttonName){
//                                                result in
//                                                if(result.isSuccessful){
//                                                    chartData = result.stockChartDataResponse!.dataSet
//                                                    let dataSet = result.stockChartDataResponse!.dataSet.map({$0.1})
//                                                    let discrepancy:Double = (dataSet.last! - dataSet[0])
//                                                    let percentChange = (discrepancy / dataSet.last! * 100)
//                                                    chartDiscrepancy = String(discrepancy.formatPrice() + "  (" + percentChange.formatPercentChange() + "%)")
//                                                    chartPeriod = "10 Days"
//                                                    themeColor = (percentChange >= 0) ? Color.green : Color.red
//                                                    isStockGaining = (percentChange >= 0) ? true : false
//                                                }
//                                                else{
//                                                    chartData = [(String, Double)]()
//                                                }
//                                            }
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[2].buttonName, buttonSelected: buttonList[2].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 3)
//                                            myAppObjects.getPriceChart(stockId: cryptoSymbol.stockId, interval: buttonList[3].buttonName){
//                                                result in
//                                                if(result.isSuccessful){
//                                                    chartData = result.stockChartDataResponse!.dataSet
//                                                    let dataSet = result.stockChartDataResponse!.dataSet.map({$0.1})
//                                                    let discrepancy:Double = (dataSet.last! - dataSet[0])
//                                                    let percentChange = (discrepancy / dataSet.last! * 100)
//                                                    chartDiscrepancy = String(discrepancy.formatPrice() + "  (" + percentChange.formatPercentChange() + "%)")
//                                                    chartPeriod = "15 Days"
//                                                    themeColor = (percentChange >= 0) ? Color.green : Color.red
//                                                    isStockGaining = (percentChange >= 0) ? true : false
//                                                }
//                                                else{
//                                                    chartData = [(String, Double)]()
//                                                }
//                                            }
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[3].buttonName, buttonSelected: buttonList[3].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 4)
//                                            myAppObjects.getPriceChart(stockId: cryptoSymbol.stockId, interval: buttonList[4].buttonName){
//                                                result in
//                                                if(result.isSuccessful){
//                                                    chartData = result.stockChartDataResponse!.dataSet
//                                                    let dataSet = result.stockChartDataResponse!.dataSet.map({$0.1})
//                                                    let discrepancy:Double = (dataSet.last! - dataSet[0])
//                                                    let percentChange = (discrepancy / dataSet.last! * 100)
//                                                    chartDiscrepancy = String(discrepancy.formatPrice() + "  (" + percentChange.formatPercentChange() + "%)")
//                                                    chartPeriod = "30 Days"
//                                                    themeColor = (percentChange >= 0) ? Color.green : Color.red
//                                                    isStockGaining = (percentChange >= 0) ? true : false
//                                                }
//                                                else{
//                                                    chartData = [(String, Double)]()
//                                                }
//                                            }
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[4].buttonName, buttonSelected: buttonList[4].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        
                                    }.padding(.horizontal)
                                    
                                    HStack{
                                        Spacer()
                                        Button(action: {
                                            orderAction = "Buy"
                                            showingOrderPage.toggle()
                                        }, label: {
                                            ButtonView(cornerRadius: 12,  text: "Buy", textColor: myColors.grayColor, textSize: 20, frameWidth: 80, frameHeight: 34, backGroundColor: themeColor, strokeBorders: false, fillColor: themeColor)
                                        }).sheet(isPresented: $showingOrderPage) {
//                                            PlaceOrderPageView(stockSymbol: $cryptoSymbol, orderAction: $orderAction)
//                                                .environmentObject(myAppObjects)
//                                                .environmentObject(userAuth)
                                        }
                                        
                                        
                                        if(cryptoSymbol.isInPortfolio){
                                            Spacer()
                                            Button(action: {
                                                orderAction = "Sell"
                                                showingOrderPage.toggle()
                                            }, label: {
                                                ButtonView(cornerRadius: 12,  text: "Sell", textColor: themeColor, textSize: 20, frameWidth: 80, frameHeight: 34, strokeBorders: false, fillColor: myColors.grayColor)
                                            }).sheet(isPresented: $showingOrderPage) {
//                                                PlaceOrderPageView(stockSymbol: $cryptoSymbol, orderAction: $orderAction)
//                                                    .environmentObject(myAppObjects)
//                                                    .environmentObject(userAuth)
                                            }
                                        }
                                        
                                        
                                        Spacer()
                                    }
//                                    if(cryptoSymbol.isInPortfolio){
//                                        MyHoldingsView(themeColor: $themeColor, holding: $stockHolding).onChange(of: showingOrderPage, perform: { value in
//                                            myAppObjects.getStockHolding(stockId: cryptoSymbol.stockId){
//                                                result in
//
//                                                if(result.isSuccessful){
//                                                    stockHolding = result.stockHoldingInfoPageResponse!
//                                                }
//                                            }
//                                        })
//                                    }
//                                    StatisticsView(stockSymbol: $cryptoSymbol, themeColor: $themeColor)
//                                    CompanyInfoView(stockSymbol: $cryptoSymbol, themeColor: $themeColor)
                                }
                                
                            }
                            
                        }
                    }
                    else{
                        VStack{
                            Image("megastonkslogo")
                                .scaleEffect(0.6)
                                .aspectRatio(contentMode: .fit)
                                .opacity(0.6)
                            Spacer()
                            Text("It seems like we do not support trading this security at this time. Please try again or select a different asset")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                .bold()
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
                }
            )
            .onAppear(perform: {
//                myAppObjects.getStockHolding(stockId: cryptoSymbol.stockId){
//                    result in
//
//                    if(result.isSuccessful){
//                        stockHolding = result.stockHoldingInfoPageResponse!
//                    }
//                }
                chartDiscrepancy = String(cryptoQuote.change24H.formatPrice() + "  (" + cryptoQuote.percentChange24H.formatPercentChange() + "%)")
                chartPeriod = "Today"
//                myAppObjects.getPriceChart(stockId: cryptoSymbol.stockId, isPriceHistory: false){
//                    result in
//                    if(result.isSuccessful){
//                        chartData = result.stockChartDataResponse!.dataSet
//                        chartDiscrepancy = String(cryptoSymbol.change.formatPrice() + "  (" + cryptoSymbol.changesPercentage.formatPercentChange() + "%)")
//                        chartPeriod = "Today"
//                        isStockGaining = (cryptoSymbol.changesPercentage >= 0) ? true : false
//                    }
//
//                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .banner(data: $myAppObjects.bannerData, show: $myAppObjects.showBanner)
    }
    

    
}

struct CryptoInfoPageView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoInfoPageView(crypto: StockSymbolModel().cryptoSymbol, cryptoQuote: CryptoQuote(StockSymbolModel().cryptoSymbol.usdQuote)).environmentObject(UserAuth())
            .environmentObject(AppObjects())
    }
}
