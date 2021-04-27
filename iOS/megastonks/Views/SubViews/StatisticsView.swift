//
//  StatisticsView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-09.
//

import SwiftUI

struct StatisticsView: View {
    @Binding var stockSymbol: StockSymbol
    @Binding var themeColor: Color
    
    let myColors = MyColors()
    var body: some View {
        
        VStack {
            VStack(alignment: .leading, spacing: 2){
                Text("Statistics")
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                    .bold()
                    .foregroundColor(themeColor)
                    .padding(.top)
                
                Rectangle()
                    .fill(myColors.lightGrayColor)
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)
                
            }
            PriceActionView(themeColor: $themeColor, label: "52 Week Price Action", lowPrice: "$\(stockSymbol.yearLow.formatPrice())", highPrice: "$\(stockSymbol.yearHigh.formatPrice())")
            PriceActionView(themeColor: $themeColor, label: "Today's Price Action", lowPrice: "$\(stockSymbol.dayLow.formatPrice())", highPrice: "$\(stockSymbol.dayHigh.formatPrice())")
            
            VStack{
                SingleStatView(label: "Today's Opening Price", value: "$\(stockSymbol.open.formatPrice())")
                SingleStatView(label: "Market Cap", value: stockSymbol.marketCap != 0 ? "\(stockSymbol.marketCap.abbreviated)" : "-")
                SingleStatView(label: "Average Volume", value: stockSymbol.avgVolume != 0 ? "\(stockSymbol.avgVolume.abbreviated)" : "-")
                SingleStatView(label: "Volume", value: stockSymbol.volume != 0 ? "\(stockSymbol.volume.abbreviated)" : "-")
                
                SingleStatView(label: "Exchange", value: stockSymbol.exchange != "" ? "\(stockSymbol.exchange)" : "-")
            }
        }.padding(.horizontal)
    }
}

struct PriceActionView: View {
    let myColors = MyColors()
    
    @Binding var themeColor: Color
    
    var label:String
    var lowPrice:String
    var highPrice:String
    var body: some View {
        
        GeometryReader { geometry in
            VStack{
                HStack{
                    Text("Low")
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom("Verdana", fixedSize: 12))
                    Spacer()
                    Text(label)
                        .font(.custom("Verdana", fixedSize: 14))
                        .bold()
                        .foregroundColor(myColors.lightGrayColor)
                    Spacer()
                    Text("High")
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom("Verdana", fixedSize: 12))
                }
                HStack{
                    VStack {
                        Text(lowPrice)
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 20))
                    }.frame(width: geometry.size.width * 0.36, alignment: .leading)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    
                    VStack {
                        Image(systemName: "chart.bar.fill")
                            .foregroundColor(themeColor)
                            .font(.custom("Verdana", fixedSize: 14))
                            .opacity(0.4)
                    }.frame(width: geometry.size.width * 0.2, alignment: .center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    
                   
                    VStack {
                        Text(highPrice)
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 20))
                    }.frame(width: geometry.size.width * 0.4, alignment: .trailing)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                }
                Rectangle()
                    .fill(myColors.lightGrayColor)
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)
            }
        }
        .frame(height: 58, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct SingleStatView: View {
    var label:String
    var value:String
    let myColors = MyColors()
    var body: some View {
        VStack{
            Text(label)
                .font(.custom("Verdana", fixedSize: 14))
                .bold()
                .foregroundColor(myColors.lightGrayColor)
            Text(value)
                .foregroundColor(.white)
                .font(.custom("Verdana", fixedSize: 20))
            Rectangle()
                .fill(myColors.lightGrayColor)
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(stockSymbol: Binding.constant(StockSymbolModel().symbols[0]), themeColor: Binding.constant(Color.red))
            .preferredColorScheme(.dark)
    }
}



