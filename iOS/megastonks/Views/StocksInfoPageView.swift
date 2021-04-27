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
    
    
    init(stock: StockSymbol) {
        _isInWatchList = State(initialValue: stock.isInWatchList)
        _stockSymbol = State(initialValue: stock)
        _themeColor = State(initialValue: (stock.change >= 0) ? Color.green : Color.red )
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
                VStack(spacing: 2){
                    HStack {
                        Spacer()
                        Button(action: {
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
                            ChartView(isStockGaining: (stockSymbol.change >= 0), themeColor: $themeColor, stock: stockSymbol ,chartButtonList: [("1D", true), ("5D", false), ("1M", false), ("3M", false), ("1Y", false), ("5Y", false)])
                            
                            HStack(spacing: 12){
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 0)
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[0].buttonName, buttonSelected: buttonList[0].buttonState, buttonColor: $themeColor)
                                        })
                                        Button(action: {
                                            changeActiveButton(activeButton: 1)
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[1].buttonName, buttonSelected: buttonList[1].buttonState, buttonColor: $themeColor)
                                        })
                                     
                                        Button(action: {
                                            changeActiveButton(activeButton: 2)
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[2].buttonName, buttonSelected: buttonList[2].buttonState, buttonColor: $themeColor)
                                        })
                                       
                                        Button(action: {
                                            changeActiveButton(activeButton: 3)
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[3].buttonName, buttonSelected: buttonList[3].buttonState, buttonColor: $themeColor)
                                        })
                                        
                                        Button(action: {
                                            changeActiveButton(activeButton: 4)
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[4].buttonName, buttonSelected: buttonList[4].buttonState, buttonColor: $themeColor)
                                        })
                                 
                                        Button(action: {
                                            
                                            changeActiveButton(activeButton: 5)
                                            
                                        }, label: {
                                            ButtonSelected(buttonName: buttonList[5].buttonName, buttonSelected: buttonList[5].buttonState, buttonColor: $themeColor)
                                        })
                               
                                        
                            }.padding(.horizontal)
                            
                            HStack{
                                Spacer()
                                Button(action: {}, label: {
                                    ButtonView(cornerRadius: 12,  text: "Buy", textColor: myColors.grayColor, textSize: 20, frameWidth: 80, frameHeight: 34, backGroundColor: themeColor, strokeBorders: false, fillColor: themeColor)
                                })
                                
                                
                                if(stockSymbol.isInPortfolio){
                                    Spacer()
                                    Button(action: {}, label: {
                                        ButtonView(cornerRadius: 12,  text: "Sell", textColor: themeColor, textSize: 20, frameWidth: 80, frameHeight: 34, strokeBorders: false, fillColor: myColors.grayColor)
                                    })
                                }

                                
                                Spacer()
                            }
                            MyHoldingsView(themeColor: $themeColor)
                            StatisticsView(stockSymbol: $stockSymbol, themeColor: $themeColor)
                            CompanyInfoView(stockSymbol: $stockSymbol, themeColor: $themeColor)
                        }
                        
                    }
                    
                }
            )
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
    }
}
