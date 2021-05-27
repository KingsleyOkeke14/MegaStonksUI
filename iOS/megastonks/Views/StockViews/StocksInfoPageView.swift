//
//  StocksInfoPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-08.
//

import SwiftUI
import SwiftUICharts

struct StocksInfoPageView: View {
    let myColors = MyColors()
    
    @State var isInWatchList:Bool
    @State var stockSymbol:StockSymbol
    @State var themeColor:Color
    
    @State var buttonList: [(buttonName: String, buttonState: Bool)] = [("1D", true), ("5D", false), ("1M", false), ("3M", false), ("1Y", false), ("5Y", false)]
    
    @State var stockHolding:StockHoldingInfoPage
    
    @State var chartData = [(String, Double)]()
    
    @State var chartDiscrepancy = ""
    
    @State var chartPeriod = ""
    
    @State var isStockGaining:Bool = false
    
    @State var showingOrderPage:Bool = false
    
    @State var orderAction:String = ""
    
    
    
    @EnvironmentObject var myAppObjects:AppObjects
    @EnvironmentObject var userAuth: UserAuth
    

    init(stock: StockSymbol) {
        _isInWatchList = State(initialValue: stock.isInWatchList)
        _stockSymbol = State(initialValue: stock)
        _themeColor = State(initialValue: (stock.change >= 0) ? Color.green : Color.red )
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
                    if(!stockSymbol.name.isEmpty){
                        VStack(spacing: 2){
                            HStack {
                                Spacer()
                                Button(action: {
                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                    impactMed.impactOccurred()
                                    if(isInWatchList){
                                        myAppObjects.removeStockFromWatchListAsync(stockToRemove: stockSymbol.stockId)
                                    }
                                    else{
                                        myAppObjects.addStockToWatchListAsync(stockToAdd: stockSymbol.stockId)
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
                myAppObjects.getStockHolding(stockId: stockSymbol.stockId){
                    result in
                    
                    if(result.isSuccessful){
                        stockHolding = result.stockHoldingInfoPageResponse!
                    }
                }
                chartDiscrepancy = String(stockSymbol.change.formatPrice() + "  (" + stockSymbol.changesPercentage.formatPercentChange() + "%)")
                chartPeriod = "Today"
                myAppObjects.getPriceChart(stockId: stockSymbol.stockId, isPriceHistory: false){
                    result in
                    if(result.isSuccessful){
                        chartData = result.chartDataResponse!.dataSet
                        chartDiscrepancy = String(stockSymbol.change.formatPrice() + "  (" + stockSymbol.changesPercentage.formatPercentChange() + "%)")
                        chartPeriod = "Today"
                        isStockGaining = (stockSymbol.changesPercentage >= 0) ? true : false
                    }
               
                }
            })
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct ButtonSelected: View {
    var buttonName:String
    var buttonSelected:Bool
    
    @Binding var buttonColor:Color
    
    let myColors = MyColors()
    var body: some View{
        ZStack{
            if(buttonSelected){
                Ellipse()
                    .fill(buttonColor)
                    .frame(height: 20)
                Text(buttonName)
                    .foregroundColor(.black)
                    .font(.custom("Verdana", fixedSize: 12))
                    .bold()
                    .padding(.horizontal, 8)
            }
            else{
                Ellipse()
                    .fill(Color.black)
                    .frame(height: 20)
                Text(buttonName)
                    .foregroundColor(.white)
                    .font(.custom("Verdana", fixedSize: 12))
                    .bold()
                    .padding(.horizontal, 8)
            }
            
        }
        
    }
    
}

struct StocksInfoPageView_Previews: PreviewProvider {
    static var previews: some View {
        StocksInfoPageView(stock: StockSymbolModel().symbols[0])
            .environmentObject(AppObjects())
    }
}
