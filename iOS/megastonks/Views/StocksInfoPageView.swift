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
    @State var isInWatchList:Bool = false
    
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
                                        .font(.title)
                                        .padding(.trailing, 10)
                                    
                                }
                                else{
                                    Image(systemName: "eye.slash")
                                        .foregroundColor(.green)
                                        .font(.title2)
                                        .padding(.trailing, 10)
                                }
                            }
                            
                            
                            
                            
                        })
                    }
                    
                    StockInfoView()
                    ScrollView{
                        VStack(spacing: 12){
                            ChartView(chartButtonList: [("1D", true), ("5D", false), ("1M", false), ("3M", false), ("1Y", false), ("5Y", false)])
                            
                            HStack{
                                Spacer()
                                Button(action: {}, label: {
                                    ButtonView(cornerRadius: 8,  text: "Buy", textColor: myColors.grayColor, frameWidth: 100, frameHeight: 40, backGroundColor: myColors.buttonStrokeGreenColor, strokeBorders: false, fillColor: myColors.buttonStrokeGreenColor)
                                })
                                
                                Spacer()
                                Button(action: {}, label: {
                                    ButtonView(cornerRadius: 8,  text: "Sell", textColor: myColors.buttonStrokeGreenColor, frameWidth: 100, frameHeight: 40, strokeBorders: false, fillColor: myColors.grayColor)
                                })
                                
                                Spacer()
                            }
                            MyHoldingsView()
                            StatisticsView()
                            CompanyInfoView()
                        }
                        
                    }
                    
                }
            )
        
    }
}

struct StocksInfoPageView_Previews: PreviewProvider {
    static var previews: some View {
        StocksInfoPageView()
    }
}
