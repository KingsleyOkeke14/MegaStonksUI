//
//  StatisticsView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-09.
//

import SwiftUI

struct StatisticsView: View {
    let myColors = MyColors()
    
    @Binding var stockSymbol: StockSymbol
    @Binding var themeColor: Color
    
    var body: some View {
        VStack{
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
                SingleStatView(label: "Today's Opening Price", value: "$\(stockSymbol.open.formatPrice())", tipMessage: "", hasTip: true, showTip: Binding.constant(false))
                SingleStatView(label: "Market Cap", value: stockSymbol.marketCap != 0 ? "\(stockSymbol.marketCap.abbreviated)" : "-", tipMessage: "", hasTip: false, showTip: Binding.constant(false))
                SingleStatView(label: "Average Volume", value: stockSymbol.avgVolume != 0 ? "\(stockSymbol.avgVolume.abbreviated)" : "-", tipMessage: "", hasTip: false, showTip: Binding.constant(false))
                SingleStatView(label: "Volume", value: stockSymbol.volume != 0 ? "\(stockSymbol.volume.abbreviated)" : "-", tipMessage: "", hasTip: false, showTip: Binding.constant(false))
                SingleStatView(label: "Exchange", value: stockSymbol.exchange != "" ? "\(stockSymbol.exchange)" : "-", tipMessage: "", hasTip: false, showTip: Binding.constant(false))
            }
        }
        .lineLimit(1)
        .padding(.horizontal)
    }
}

struct CryptoStatisticsView: View {
    let myColors = MyColors()
    
    @Binding var cryptoSymbol: CryptoSymbol
    var cryptoQuote: CryptoQuote
    @Binding var themeColor: Color
    @State var showTipRank: Bool = false
    
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
            VStack{
                SingleStatView(label: "Rank", value: cryptoSymbol.crypto.cmcRank != 0 ? "\(cryptoSymbol.crypto.cmcRank)" : "-", tipMessage: "Assets are ranked based on the value of their market cap", hasTip: true, showTip: $showTipRank)
                SingleStatView(label: "Inception Date", value: !cryptoSymbol.crypto.dateAdded.isEmpty ? "\(cryptoSymbol.crypto.dateAdded)" : "-", tipMessage: "", hasTip: false, showTip: Binding.constant(false))
                SingleStatView(label: "Max Supply", value: cryptoSymbol.crypto.maxSupply != 0 ? "\(cryptoSymbol.crypto.maxSupply.abbreviated)" : "-", tipMessage: "", hasTip: false, showTip: Binding.constant(false))
                SingleStatView(label: "Circulating Supply", value: cryptoSymbol.crypto.circulatingSupply != 0 ? "\(cryptoSymbol.crypto.circulatingSupply.abbreviated())" : "-", tipMessage: "", hasTip: false, showTip: Binding.constant(false))
                SingleStatView(label: "Market Cap", value: cryptoQuote.marketCap != 0 ? "\(cryptoQuote.marketCap.abbreviated())" : "-", tipMessage: "", hasTip: false, showTip: Binding.constant(false))
                SingleStatView(label: "24Hr Volume", value: cryptoQuote.volume24H != 0 ? "\(cryptoQuote.volume24H.abbreviated())" : "-", tipMessage: "", hasTip: false, showTip: Binding.constant(false))
            }
            VStack(alignment: .leading, spacing: 2){
                Text("Price Movement")
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                    .bold()
                    .foregroundColor(themeColor)
                    .padding(.top)
                SingleStatPriceView(label: "1Hr Change", percentage: cryptoQuote.percentChange1H, price: cryptoQuote.change1H, color: cryptoQuote.percentChange1H > 0 ? .green : .red)
                SingleStatPriceView(label: "24Hr Change", percentage: cryptoQuote.percentChange24H, price: cryptoQuote.percentChange24H, color: cryptoQuote.percentChange24H > 0 ? .green : .red)
                SingleStatPriceView(label: "7D Change", percentage: cryptoQuote.percentChange7D, price: cryptoQuote.change7D, color: cryptoQuote.percentChange7D > 0 ? .green : .red)
                SingleStatPriceView(label: "30D Change", percentage: cryptoQuote.percentChange30D, price: cryptoQuote.change30D, color: cryptoQuote.percentChange30D > 0 ? .green : .red)
                SingleStatPriceView(label: "60D Change", percentage: cryptoQuote.percentChange60D, price: cryptoQuote.change60D, color: cryptoQuote.percentChange60D > 0 ? .green : .red)
                SingleStatPriceView(label: "90D Change", percentage: cryptoQuote.percentChange90D, price: cryptoQuote.change90D, color: cryptoQuote.percentChange90D > 0 ? .green : .red)
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
        .frame(height: 58, alignment: .center)
    }
}

struct SingleStatView: View {
    var label:String
    var value:String
    var tipMessage:String
    var hasTip:Bool
    @Binding var showTip:Bool
    let myColors = MyColors()
    var body: some View {
        VStack{
            HStack {
                if(!showTip){
                    Text(label)
                        .font(.custom("Verdana", fixedSize: 14))
                        .bold()
                        .foregroundColor(myColors.lightGrayColor)
                }
                if(hasTip){
                    Button(action: {
                        showTip.toggle()
                    }, label: {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.white)
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                    })
                }
                if(showTip){
                    Text(tipMessage)
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                        .foregroundColor(.white)
                        .lineLimit(4)
                        .multilineTextAlignment(.center)
                }
            }
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

struct SingleStatPriceView: View {
    var label:String
    var percentage:Double
    var price:Double
    var color:Color
    let myColors = MyColors()
    var body: some View {
        VStack{
            Text(label)
                .font(.custom("Verdana", fixedSize: 14))
                .bold()
                .foregroundColor(myColors.lightGrayColor)
            Text("\(price.signToString())$\(fabs(price).formatPrice()) (\(percentage.formatPercentChange())%)")
                .foregroundColor(color)
                .font(.custom("Verdana", fixedSize: 20))
                .opacity(0.6)
            Rectangle()
                .fill(myColors.lightGrayColor)
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        
        CryptoStatisticsView(cryptoSymbol: Binding.constant(StockSymbolModel().cryptoSymbol), cryptoQuote: CryptoQuote(StockSymbolModel().cryptoSymbol.cadQuote), themeColor: Binding.constant(Color.red))
            .preferredColorScheme(.dark)
        
                StatisticsView(stockSymbol: Binding.constant(StockSymbolModel().symbols[0]), themeColor: Binding.constant(Color.red))
                    .preferredColorScheme(.dark)
    }
}
