//
//  CryptoInfoPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-28.
//

import SwiftUI

struct CryptoInfoPageView: View {
    let myColors = MyColors()
    
    @State var cryptoQuote:CryptoQuote?
    var cryptoToSearch: Int = 0
    
    @State var isInWatchList:Bool
    @State var cryptoSymbol:CryptoSymbol?
    @State var themeColor:Color
    @State var isLoading:Bool = true
    
    
    @State var buttonList: [(buttonName: String, buttonState: Bool)] = [("1D", true), ("5D", false), ("10D", false), ("15D", false), ("30D", false)]
    
    @State var cryptoHolding:HoldingInfoPage
    
    @State var chartData:[(String, Double)]? = nil
    @State var chartDataToday:[(String, Double)]? = nil
    @State var chartDataHistorical:[(String, Double)]? = nil
    
    @State var chartDiscrepancy = ""
    
    @State var chartPeriod = ""
    
    @State var isStockGaining:Bool = false
    
    @State var showingOrderPage:Bool = false
    
    @State var orderAction:String = ""
    
    @EnvironmentObject var myAppObjects:AppObjects
    @EnvironmentObject var userAuth: UserAuth
    
    
    init(cryptoToSearch: Int, crypto: CryptoSymbol?, cryptoQuote: CryptoQuote?) {
        self.cryptoToSearch = cryptoToSearch
        _cryptoQuote = State(initialValue: cryptoQuote)
        _cryptoSymbol = State(initialValue: crypto ?? nil)
        _isInWatchList = State(initialValue: crypto?.isInWatchlist ?? false)
        _themeColor = State(initialValue: (cryptoQuote?.percentChange24H ?? 0 >= 0) ? Color.green : Color.red )
        _cryptoHolding = State.init( initialValue: HoldingInfoPage(HoldingResponseInfoPage(id: 0, averageCost: 0, quantity: 0, marketValue: 0, percentReturnToday: 0, moneyReturnToday: 0, percentReturnTotal: 0, moneyReturnTotal: 0, percentOfPortfolio: 0, lastUpdated: "")))
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
                    if(cryptoSymbol != nil){
                        VStack(spacing: 2){
                            HStack {
                                Spacer()
                                Button(action: {
                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                    impactMed.impactOccurred()
                                    if(isInWatchList){
                                        myAppObjects.removeCryptoFromWatchListAsync(cryptoToRemove: cryptoSymbol!.crypto.cryptoId)
                                    }
                                    else{
                                        myAppObjects.addCryptoToWatchListAsync(cryptoToAdd: cryptoSymbol!.crypto.cryptoId)
                                    }
                                    isInWatchList.toggle()
                                }, label: {
                                    HStack{
                                            Image(systemName: isInWatchList ? "eye": "eye.slash")
                                                .foregroundColor(themeColor)
                                                .font(.custom("", fixedSize: 18))
                                                .padding(.trailing, 10)
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
                                    chartDiscrepancy = String(cryptoQuote!.change24H.formatPrice() + "  (" + cryptoQuote!.percentChange24H.formatPercentChange() + "%)")
                                    chartPeriod = "Today"
                                    chartData = chartDataToday
                                    isStockGaining = (cryptoQuote!.percentChange24H >= 0) ? true : false
                                    themeColor = (cryptoQuote!.percentChange24H >= 0) ? Color.green : Color.red
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[0].buttonName, buttonSelected: buttonList[0].buttonState, buttonColor: $themeColor)
                                            
                                        })
                                        Button(action: {
                                            changeActiveButton(activeButton: 1)
                                                if(chartDataHistorical != nil){
                                                    let dataSet = chartDataHistorical?.map({$0.1})
                                                    if(dataSet?[5] != nil){
                                                        let discrepancy: Double = dataSet![5] - dataSet!.first!
                                                        let percentChange = (discrepancy / dataSet![5] * 100)
                                                        chartDiscrepancy = String(discrepancy.formatPrice() + "  (" + percentChange.formatPercentChange() + "%)")
                                                            chartPeriod = "5 Days"
                                                        chartData = Array(chartDataHistorical![0..<6]) as Array
                                                            isStockGaining = (percentChange >= 0) ? true : false
                                                        themeColor = (percentChange >= 0) ? Color.green : Color.red
                                                    }
                                                }
                                                else if (chartDataHistorical == nil){
                                                    chartData = [(String, Double)]()
                                                }
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[1].buttonName, buttonSelected: buttonList[1].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 2)
                                            if(chartDataHistorical != nil){
                                                let dataSet = chartDataHistorical?.map({$0.1})
                                                if(dataSet?[10] != nil){
                                                    let discrepancy: Double = dataSet![10] - dataSet!.first!
                                                    let percentChange = (discrepancy / dataSet![10] * 100)
                                                    chartDiscrepancy = String(discrepancy.formatPrice() + "  (" + percentChange.formatPercentChange() + "%)")
                                                        chartPeriod = "10 Days"
                                                    chartData = Array(chartDataHistorical![0..<11]) as Array
                                                        isStockGaining = (percentChange >= 0) ? true : false
                                                    themeColor = (percentChange >= 0) ? Color.green : Color.red
                                                }
                                            }
                                            else if (chartDataHistorical == nil){
                                                chartData = [(String, Double)]()
                                            }
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[2].buttonName, buttonSelected: buttonList[2].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 3)
                                            if(chartDataHistorical != nil){
                                                let dataSet = chartDataHistorical?.map({$0.1})
                                                if(dataSet?[15] != nil){
                                                    let discrepancy: Double = dataSet![15] - dataSet!.first!
                                                    let percentChange = (discrepancy / dataSet![15] * 100)
                                                    chartDiscrepancy = String(discrepancy.formatPrice() + "  (" + percentChange.formatPercentChange() + "%)")
                                                        chartPeriod = "15 Days"
                                                    chartData = Array(chartDataHistorical![0..<16]) as Array
                                                        isStockGaining = (percentChange >= 0) ? true : false
                                                    themeColor = (percentChange >= 0) ? Color.green : Color.red
                                                }
                                            }
                                            else if (chartDataHistorical == nil){
                                                chartData = [(String, Double)]()
                                            }
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[3].buttonName, buttonSelected: buttonList[3].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 4)
                                            if(chartDataHistorical != nil){
                                                chartDiscrepancy = String(cryptoQuote!.change30D.formatPrice() + "  (" + cryptoQuote!.percentChange30D.formatPercentChange() + "%)")
                                                        chartPeriod = "30 Days"
                                                        chartData = chartDataHistorical
                                                        isStockGaining = (cryptoQuote!.change30D >= 0) ? true : false
                                                themeColor = (cryptoQuote!.change30D >= 0) ? Color.green : Color.red
                                                
                                            }
                                            else if (chartDataHistorical == nil){
                                                chartData = [(String, Double)]()
                                            }
                                            
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
                                            PlaceOrderCryptoPageView(cryptoSymbol: $cryptoSymbol, cryptoQuote: $cryptoQuote, orderAction: $orderAction)
                                                .environmentObject(myAppObjects)
                                                .environmentObject(userAuth)
                                        }
                                        
                                        
                                        if(cryptoSymbol!.isInPortfolio){
                                            Spacer()
                                            Button(action: {
                                                orderAction = "Sell"
                                                showingOrderPage.toggle()
                                            }, label: {
                                                ButtonView(cornerRadius: 12,  text: "Sell", textColor: themeColor, textSize: 20, frameWidth: 80, frameHeight: 34, strokeBorders: false, fillColor: myColors.grayColor)
                                            }).sheet(isPresented: $showingOrderPage) {
                                                PlaceOrderCryptoPageView(cryptoSymbol: $cryptoSymbol, cryptoQuote: $cryptoQuote, orderAction: $orderAction)
                                                    .environmentObject(myAppObjects)
                                                    .environmentObject(userAuth)
                                            }
                                        }          
                                        Spacer()
                                    }
                                    if(cryptoSymbol!.isInPortfolio){
                                        MyHoldingsView(isCrypto: true, themeColor: $themeColor, holding: $cryptoHolding)
                                            .onChange(of: showingOrderPage, perform: { value in
                                                myAppObjects.getCryptoHolding(cryptoId: cryptoSymbol!.crypto.cryptoId){
                                                result in

                                                if(result.isSuccessful){
                                                    cryptoHolding = result.holdingInfoPageResponse!
                                                }
                                            }
                                        })
                                    }
                                    CryptoStatisticsView(cryptoSymbol: $cryptoSymbol, cryptoQuote: userAuth.user.currency == "CAD" ? CryptoQuote(cryptoSymbol!.cadQuote) : CryptoQuote(cryptoSymbol!.usdQuote), themeColor: $themeColor)
                                    TokenInfoView(cryptoSymbol: $cryptoSymbol, themeColor: $themeColor)
                                }
                                
                            }.animation(.easeIn.delay(0.2))
                            
                        }
                    }
                    
                    else {
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
                        .overlay(
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
                    }
                }
            )
            .onAppear(perform: {
                if(cryptoSymbol == nil || cryptoQuote == nil){
                    myAppObjects.getCryptoInfo(cryptoId: cryptoToSearch){
                        result in
                        
                        if(result.isSuccessful){
                            cryptoSymbol = result.cryptoInfoSearchCryptosPage!
                            cryptoQuote = userAuth.user.currency == "USD" ? CryptoQuote(cryptoSymbol!.usdQuote) : CryptoQuote(cryptoSymbol!.cadQuote)
                            themeColor =  (cryptoQuote!.percentChange24H >= 0) ? Color.green : Color.red
                            myAppObjects.getCryptoPriceChart(cryptoId: cryptoSymbol!.crypto.cryptoId, isPriceHistory: false){
                                result in
                                if(result.isSuccessful){
                                    chartDiscrepancy = String(cryptoQuote!.change24H.formatPrice() + "  (" + cryptoQuote!.percentChange24H.formatPercentChange() + "%)")
                                    chartPeriod = "Today"
                                    chartDataToday = result.chartDataResponse!.dataSet
                                    chartData = chartDataToday
                                    isStockGaining = (cryptoQuote!.percentChange24H >= 0) ? true : false
                                }
                                else{
                                    chartDataToday = [(String, Double)]()
                                    chartData = chartDataToday
                                }

                            }
                            
                            myAppObjects.getCryptoPriceChart(cryptoId: cryptoSymbol!.crypto.cryptoId, isPriceHistory: true){
                                result in
                                if(result.isSuccessful){
                                    chartDataHistorical = result.chartDataResponse!.dataSet
                                }
                                else{
                                    chartDataHistorical = nil
                                }

                            }
                        }
                        isLoading = false
                    }
                    myAppObjects.getCryptoHolding(cryptoId: cryptoToSearch){
                                        result in
                    
                                        if(result.isSuccessful){
                                            cryptoHolding = result.holdingInfoPageResponse!
                                        }
                                    }
                }
                else{
                    myAppObjects.getCryptoHolding(cryptoId: cryptoSymbol!.crypto.cryptoId){
                        result in
                        
                        if(result.isSuccessful){
                            cryptoHolding = result.holdingInfoPageResponse!
                        }
                     }
                    
                    myAppObjects.getCryptoPriceChart(cryptoId: cryptoSymbol!.crypto.cryptoId, isPriceHistory: false){
                        result in
                        if(result.isSuccessful){
                            chartDiscrepancy = String(cryptoQuote!.change24H.formatPrice() + "  (" + cryptoQuote!.percentChange24H.formatPercentChange() + "%)")
                            chartPeriod = "Today"
                        
                            chartDataToday = result.chartDataResponse!.dataSet
                            chartData = chartDataToday
                            isStockGaining = (cryptoQuote!.percentChange24H >= 0) ? true : false
                        }

                    }
                    
                    myAppObjects.getCryptoPriceChart(cryptoId: cryptoSymbol!.crypto.cryptoId, isPriceHistory: true){
                        result in
                        if(result.isSuccessful){
                            chartDataHistorical = result.chartDataResponse!.dataSet
                        }
                        else{
                            chartDataHistorical = nil
                        }

                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .banner(data: $myAppObjects.bannerData, show: $myAppObjects.showBanner)
            }
    
}

struct CryptoInfoPageView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoInfoPageView(cryptoToSearch: 0, crypto: StockSymbolModel().cryptoSymbol, cryptoQuote: CryptoQuote(StockSymbolModel().cryptoSymbol.usdQuote))
            .preferredColorScheme(.dark)
            .environmentObject(UserAuth())
            .environmentObject(AppObjects())
    }
}
