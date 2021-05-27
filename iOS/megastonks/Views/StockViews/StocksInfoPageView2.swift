//
//  StockInfoPage2.swift
//  megastonks
//  This view is the exact same view as the StockInfoPageView. The only difference is that this view takes in a stockelement response and requests for the stock information itself 
//  Created by Kingsley Okeke on 2021-04-28.
//

import SwiftUI

struct StocksInfoPageView2: View {
    
    let myColors = MyColors()
    
    var stockToSearch:StockSearchResult
    
    @State var stockSymbol:StockSymbol
    @State var stockHolding:StockHoldingInfoPage
    
    @State var themeColor:Color = Color.gray
    
    @State var buttonList: [(buttonName: String, buttonState: Bool)] = [("1D", true), ("5D", false), ("1M", false), ("3M", false), ("1Y", false), ("5Y", false)]
    
    @State var chartData = [(String, Double)]()
    
    var showOrderButtons:Bool
    var showWatcListButton:Bool
    
    @State var chartDiscrepancy = ""
    
    @State var chartPeriod = ""
    
    @State var isStockGaining:Bool = false
    
    @EnvironmentObject var myAppObjects:AppObjects
    @EnvironmentObject var userAuth: UserAuth
    
    @State var isLoading:Bool = true
    
    @State var showingOrderPage:Bool = false
    
    @State var orderAction:String = ""
    
    init(stockToGet: StockSearchResult, showOrderButtons: Bool, showWatchListButton: Bool) {
        //_themeColor = State(initialValue: (stock.change >= 0) ? Color.green : Color.red )
        stockToSearch = stockToGet
        _stockSymbol = State.init(initialValue: StockSymbol(StockElementResponse(stockId: 0, symbol: "", name: "", description: "", price: nil, currency: "", changesPercentage: nil, change: nil, dayLow: nil, dayHigh: nil, yearHigh: nil, yearLow: nil, marketCap: nil, priceAvg50: nil, priceAvg200: nil, volume: nil, avgVolume: nil, exchange: nil, open: nil, previousClose: nil, isInWatchList: false, isInPortfolio: false)))
        _stockHolding = State.init( initialValue: StockHoldingInfoPage(HoldingResponseInfoPage(id: 0, averageCost: 0, quantity: 0, marketValue: 0, percentReturnToday: 0, moneyReturnToday: 0, percentReturnTotal: 0, moneyReturnTotal: 0, percentOfPortfolio: 0, lastUpdated: "")))
        self.showOrderButtons = showOrderButtons
        self.showWatcListButton = showWatchListButton
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
                    if(!isLoading && !stockSymbol.name.isEmpty){
                        VStack(spacing: 2){
                            
                            if(showWatcListButton){
                            HStack {
                                Spacer()
                                Button(action: {
                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                    impactMed.impactOccurred()
                                    if(stockSymbol.isInWatchList){
                                        myAppObjects.removeStockFromWatchListAsync(stockToRemove: stockSymbol.stockId)
                                    }
                                    else{
                                        myAppObjects.addStockToWatchListAsync(stockToAdd: stockSymbol.stockId)
                                    }
                                    stockSymbol.isInWatchList.toggle()
                                }, label: {
                                    HStack{
                                        if(stockSymbol.isInWatchList){
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
                            }
                            StockInfoView(stockSymbol: $stockSymbol, highlightColor: $themeColor)
                            ScrollView{
                                VStack(spacing: 12){
                                    ChartView(isStockGaining: $isStockGaining, themeColor: $themeColor, data: $chartData, chartDiscrepancy: $chartDiscrepancy, chartLabel: $chartPeriod, stock: stockSymbol)
                                    
                                    HStack(spacing: 12){
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 0)
                                            myAppObjects.getPriceChart(stockId: stockSymbol.stockId, isPriceHistory: false){
                                                result in
                                                if(result.isSuccessful){
                                                    chartData = result.chartDataResponse!.dataSet
                                                    chartDiscrepancy = String(stockSymbol.change.formatPrice() + "  (" + stockSymbol.changesPercentage.formatPercentChange() + "%)")
                                                    chartPeriod = "Today"
                                                    themeColor = (stockSymbol.change >= 0) ? Color.green : Color.red
                                                    isStockGaining = (stockSymbol.change >= 0) ? true : false
                                                }
                                                else{
                                                    chartData = [(String, Double)]()
                                                }
                                            }
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[0].buttonName, buttonSelected: buttonList[0].buttonState, buttonColor: $themeColor)
                                            
                                        })
                                        Button(action: {
                                            changeActiveButton(activeButton: 1)
                                            myAppObjects.getPriceChart(stockId: stockSymbol.stockId, interval: buttonList[1].buttonName){
                                                result in
                                                if(result.isSuccessful){
                                                    chartData = result.chartDataResponse!.dataSet
                                                    let dataSet = result.chartDataResponse!.dataSet.map({$0.1})
                                                    let discrepancy:Double = (dataSet.last! - dataSet[0])
                                                    let percentChange = (discrepancy / dataSet.last! * 100)
                                                    chartDiscrepancy = String(discrepancy.formatPrice() + "  (" + percentChange.formatPercentChange() + "%)")
                                                    chartPeriod = "5 Days"
                                                    themeColor = (percentChange >= 0) ? Color.green : Color.red
                                                    isStockGaining = (percentChange >= 0) ? true : false
                                                }
                                                else{
                                                    chartData = [(String, Double)]()
                                                }
                                            }
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[1].buttonName, buttonSelected: buttonList[1].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 2)
                                            myAppObjects.getPriceChart(stockId: stockSymbol.stockId, interval: buttonList[2].buttonName){
                                                result in
                                                if(result.isSuccessful){
                                                    chartData = result.chartDataResponse!.dataSet
                                                    let dataSet = result.chartDataResponse!.dataSet.map({$0.1})
                                                    let discrepancy:Double = (dataSet.last! - dataSet[0])
                                                    let percentChange = (discrepancy / dataSet.last! * 100)
                                                    chartDiscrepancy = String(discrepancy.formatPrice() + "  (" + percentChange.formatPercentChange() + "%)")
                                                    chartPeriod = "1 Month"
                                                    themeColor = (percentChange >= 0) ? Color.green : Color.red
                                                    isStockGaining = (percentChange >= 0) ? true : false
                                                }
                                                else{
                                                    chartData = [(String, Double)]()
                                                }
                                            }
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[2].buttonName, buttonSelected: buttonList[2].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 3)
                                            myAppObjects.getPriceChart(stockId: stockSymbol.stockId, interval: buttonList[3].buttonName){
                                                result in
                                                if(result.isSuccessful){
                                                    chartData = result.chartDataResponse!.dataSet
                                                    let dataSet = result.chartDataResponse!.dataSet.map({$0.1})
                                                    let discrepancy:Double = (dataSet.last! - dataSet[0])
                                                    let percentChange = (discrepancy / dataSet.last! * 100)
                                                    chartDiscrepancy = String(discrepancy.formatPrice() + "  (" + percentChange.formatPercentChange() + "%)")
                                                    chartPeriod = "3 Months"
                                                    themeColor = (percentChange >= 0) ? Color.green : Color.red
                                                    isStockGaining = (percentChange >= 0) ? true : false
                                                }
                                                else{
                                                    chartData = [(String, Double)]()
                                                }
                                            }
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[3].buttonName, buttonSelected: buttonList[3].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 4)
                                            myAppObjects.getPriceChart(stockId: stockSymbol.stockId, interval: buttonList[4].buttonName){
                                                result in
                                                if(result.isSuccessful){
                                                    chartData = result.chartDataResponse!.dataSet
                                                    let dataSet = result.chartDataResponse!.dataSet.map({$0.1})
                                                    let discrepancy:Double = (dataSet.last! - dataSet[0])
                                                    let percentChange = (discrepancy / dataSet.last! * 100)
                                                    chartDiscrepancy = String(discrepancy.formatPrice() + "  (" + percentChange.formatPercentChange() + "%)")
                                                    chartPeriod = "1 Year"
                                                    themeColor = (percentChange >= 0) ? Color.green : Color.red
                                                    isStockGaining = (percentChange >= 0) ? true : false
                                                }
                                                else{
                                                    chartData = [(String, Double)]()
                                                }
                                            }
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[4].buttonName, buttonSelected: buttonList[4].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        Button(action: {
                                            
                                            changeActiveButton(activeButton: 5)
                                            myAppObjects.getPriceChart(stockId: stockSymbol.stockId, interval: buttonList[5].buttonName){
                                                result in
                                                if(result.isSuccessful){
                                                    chartData = result.chartDataResponse!.dataSet
                                                    let dataSet = result.chartDataResponse!.dataSet.map({$0.1})
                                                    let discrepancy:Double = (dataSet.last! - dataSet[0])
                                                    let percentChange = (discrepancy / dataSet.last! * 100)
                                                    chartDiscrepancy = String(discrepancy.formatPrice() + "  (" + percentChange.formatPercentChange() + "%)")
                                                    chartPeriod = "5 years"
                                                    themeColor = (percentChange >= 0) ? Color.green : Color.red
                                                    isStockGaining = (percentChange >= 0) ? true : false
                                                }
                                                else{
                                                    chartData = [(String, Double)]()
                                                }
                                            }
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[5].buttonName, buttonSelected: buttonList[5].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        
                                    }.padding(.horizontal)
                                    if(showOrderButtons){
                                        HStack{
                                            Spacer()
                                            Button(action: {
                                                orderAction = "Buy"
                                                showingOrderPage.toggle()
                                                
                                            }, label: {
                                                ButtonView(cornerRadius: 12,  text: "Buy", textColor: myColors.grayColor, textSize: 20, frameWidth: 80, frameHeight: 34, backGroundColor: themeColor, strokeBorders: false, fillColor: themeColor)
                                            }).sheet(isPresented: $showingOrderPage) {
                                                PlaceOrderPageView(stockSymbol: $stockSymbol, orderAction: $orderAction)
                                                    .environmentObject(myAppObjects)
                                                    .environmentObject(userAuth)
                                            }
                                            
                                            
                                            if(stockSymbol.isInPortfolio){
                                                Spacer()
                                                Button(action: {
                                                    orderAction = "Sell"
                                                    showingOrderPage.toggle()
                                                    
                                                }, label: {
                                                    ButtonView(cornerRadius: 12,  text: "Sell", textColor: themeColor, textSize: 20, frameWidth: 80, frameHeight: 34, strokeBorders: false, fillColor: myColors.grayColor)
                                                }).sheet(isPresented: $showingOrderPage) {
                                                    PlaceOrderPageView(stockSymbol: $stockSymbol, orderAction: $orderAction)
                                                        .environmentObject(myAppObjects)
                                                        .environmentObject(userAuth)
                                                }
                                            }
                                            
                                            
                                            Spacer()
                                        }
                                    }
                                    
                                    if(stockSymbol.isInPortfolio){
                                        MyHoldingsView(themeColor: $themeColor, holding: $stockHolding).onChange(of: showingOrderPage, perform: { value in
                                            myAppObjects.getStockHolding(stockId: stockSymbol.stockId){
                                                result in
                                                
                                                if(result.isSuccessful){
                                                    stockHolding = result.stockHoldingInfoPageResponse!
                                                }
                                            }
                                        })
                                    }
                                    StatisticsView(stockSymbol: $stockSymbol, themeColor: $themeColor)
                                    CompanyInfoView(stockSymbol: $stockSymbol, themeColor: $themeColor)
                                }
                                
                            }
                            
                        }
                    }
                    else{
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
                }.overlay(
                    VStack{
                        if(isLoading){
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
            ).onAppear(
                perform: {
                    myAppObjects.getStockInfo(stockId: stockToSearch.stockId){
                        result in
                        
                        if(result.isSuccessful){
                            stockSymbol = result.stockInfoSearchStocksPage!
                            myAppObjects.getPriceChart(stockId: stockToSearch.stockId, isPriceHistory: false){
                                result in
                                if(result.isSuccessful){
                                    chartDiscrepancy = String(stockSymbol.change.formatPrice() + "  (" + stockSymbol.changesPercentage.formatPercentChange() + "%)")
                                    chartPeriod = "Today"
                                    chartData = result.chartDataResponse!.dataSet
                                    isStockGaining = (stockSymbol.change >= 0) ? true : false
                                }
                                
                            }
                        }
                        isLoading = false
                        themeColor =  (stockSymbol.change >= 0) ? Color.green : Color.red
                    }
                    
                    myAppObjects.getStockHolding(stockId: stockToSearch.stockId){
                        result in
                        
                        if(result.isSuccessful){
                            stockHolding = result.stockHoldingInfoPageResponse!
                        }
                    }
                    
                }
            )
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

struct StockInfoPage2_Previews: PreviewProvider {
    static var previews: some View {
        StocksInfoPageView2(stockToGet: StockSearchResult(StockSearchElementResponse(id: 0, symbol: "", companyName: "", marketCap: 0, sector: "", industry: "", beta: 0.0, price: 0.0, lastAnnualDividend: 0.0, volume: 0, exchange: "", exchangeShortName: "", country: "", isEtf: false, isActivelyTrading: false, lastUpdated: "")), showOrderButtons: true, showWatchListButton: true).environmentObject(AppObjects())
    }
}
