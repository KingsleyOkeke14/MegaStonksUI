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
    
    init(stock: StockSymbol) {
        _isInWatchList = State(initialValue: stock.isInWatchList)
        _stockSymbol = State(initialValue: stock)
    }
    
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack(spacing: 2){
                    HStack {
                        Spacer()
                        Button(action: {
                            isInWatchList.toggle()
                        }, label: {
                            HStack{
                                if(isInWatchList){
                                    Image(systemName: "eye")
                                        .foregroundColor(.green)
                                        .font(.custom("", fixedSize: 18))
                                        .padding(.trailing, 10)
                                
                                }
                                else{
                                    Image(systemName: "eye.slash")
                                        .foregroundColor(.green)
                                        .font(.custom("", fixedSize: 18))
                                        .padding(.trailing, 10)
                                }
                            }
                        })
                    }
                    
                    StockInfoView(stockSymbol: $stockSymbol)
                    ScrollView{
                        VStack(spacing: 12){
                            ChartView(stock: stockSymbol ,chartButtonList: [("1D", true), ("5D", false), ("1M", false), ("3M", false), ("1Y", false), ("5Y", false)])
                            
                            
                            HStack{
                                Spacer()
                                Button(action: {}, label: {
                                    ButtonView(cornerRadius: 12,  text: "Buy", textColor: myColors.grayColor, textSize: 20, frameWidth: 80, frameHeight: 34, backGroundColor: myColors.buttonStrokeGreenColor, strokeBorders: false, fillColor: myColors.buttonStrokeGreenColor)
                                })
                                
                                
                                if(stockSymbol.isInPortfolio){
                                    Spacer()
                                    Button(action: {}, label: {
                                        ButtonView(cornerRadius: 12,  text: "Sell", textColor: myColors.buttonStrokeGreenColor, textSize: 20, frameWidth: 80, frameHeight: 34, strokeBorders: false, fillColor: myColors.grayColor)
                                    })
                                }

                                
                                Spacer()
                            }
                            MyHoldingsView()
                            StatisticsView()
                            CompanyInfoView()
                        }
                        
                    }
                    
                }
            )
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct StocksInfoPageView_Previews: PreviewProvider {
    static var previews: some View {
        StocksInfoPageView(stock: StockSymbolModel().symbols[0])
    }
}
