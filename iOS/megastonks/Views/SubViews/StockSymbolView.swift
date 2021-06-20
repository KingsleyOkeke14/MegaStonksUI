//
//  StockSymbolView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-03.
//

import SwiftUI

struct StockSymbolView: View {
    
    let myColors = MyColors()
    
    var stock:StockSymbol
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack(spacing: 10) {
                    
                    RoundedRectangle(cornerRadius: 14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.gray.opacity(0), lineWidth: 1)
                                
                        ).foregroundColor(myColors.grayColor) 
                }
            }
            .overlay(
                HStack{
                    HStack {
                        VStack(alignment: .leading){
                            Text(stock.symbol)
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                .bold()
                                .foregroundColor(.white)
                            Text(stock.exchange)
                                .font(.custom("Helvetica", fixedSize: 14))
                                .foregroundColor(.gray)
                        }
                        if(stock.isInPortfolio){
                            Text("P")
                                .font(.custom("Arial Bold", fixedSize:8))
                                .foregroundColor(.black)
                                .padding(2)
                                .padding(.horizontal, 2)
                                .background(stock.change >= 0 ? myColors.greenColor: myColors.redColor)
                                .cornerRadius(30)
                        }
                        
                    }.frame(width: geometry.size.width * 0.3, alignment: .leading)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    
                    
                    Spacer()
                    VStack(spacing: 4){
                        
                        Image(systemName: stock.change >= 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                            .foregroundColor(stock.change >= 0 ? .green : .red)
                            .scaleEffect(1.4)
                        
                        Text(String("(" +  stock.changesPercentage.formatPercentChange() + "%)"))
                            .font(.custom("Helvetica", fixedSize: 14))
                            .foregroundColor(stock.change >= 0 ? .green : .red)
                        
                    }.frame(width: geometry.size.width * 0.3, alignment: .center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("$" + stock.price.formatPrice())
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                            .bold()
                            .foregroundColor(.white)
                        HStack{
                            Text(stock.change.formatPrice())
                                .font(.custom("Helvetica", fixedSize: 14))
                                .foregroundColor(.gray)
                            Text(stock.currency)
                                .font(.custom("Helvetica", fixedSize: 12))
                                .foregroundColor(.gray)
                        }
                    }.frame(width: geometry.size.width * 0.3, alignment: .trailing)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                }.padding(.horizontal, 6)
            )
            
            
        }
        .frame(height: 64, alignment: .center)
       
    }
}


struct CryptoSymbolView: View {
    
    let myColors = MyColors()
    
    var cryptoSymbol:CryptoSymbol
    var cryptoQuote: CryptoQuote
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 10) {
                    
                    RoundedRectangle(cornerRadius: 14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.gray.opacity(0), lineWidth: 1)
                                
                        ).foregroundColor(myColors.grayColor)
                        //.shadow(color: Color.gray.opacity(0), radius: 1, x: 0, y: 0)
                        
                }
            }
            .overlay(
                HStack{
                    HStack {
                        AsyncImage(url: URL(string: cryptoSymbol.info.logo)!,
                                   placeholder: { Image("blackImage") },
                                   image: { Image(uiImage: $0).resizable() })
                            .frame(width: 40, height: 40, alignment: .center)
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .shadow(radius: 8)
                        VStack(alignment: .leading){
                            Text(cryptoSymbol.crypto.name)
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                .bold()
                                .foregroundColor(.white)
                            Text(cryptoSymbol.crypto.symbol.uppercased())
                                .font(.custom("Helvetica", fixedSize: 14))
                                .foregroundColor(.gray)
                        }
                        if(cryptoSymbol.isInPortfolio){
                            Text("P")
                                .font(.custom("Arial Bold", fixedSize:8))
                                .foregroundColor(.black)
                                .padding(2)
                                .padding(.horizontal, 2)
                                .background(cryptoQuote.percentChange24H >= 0 ? myColors.greenColor: myColors.redColor)
                                .cornerRadius(30)
                        }
                        
                    }.frame(width: geometry.size.width * 0.4, alignment: .leading)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    
                    VStack(spacing: 4){
                        
                        Image(systemName: cryptoQuote.percentChange24H >= 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                            .foregroundColor(cryptoQuote.percentChange24H >= 0 ? .green : .red)
                            .scaleEffect(1.4)
                        
                        Text(String("(" +  cryptoQuote.percentChange24H.formatPercentChange() + "%)"))
                            .font(.custom("Helvetica", fixedSize: 14))
                            .foregroundColor(cryptoQuote.percentChange24H >= 0 ? .green : .red)
                        
                    }.frame(width: geometry.size.width * 0.2, alignment: .center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("$" + cryptoQuote.price.formatPrice())
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                            .bold()
                            .foregroundColor(.white)
                        HStack{
                            Text(cryptoQuote.change24H.formatPrice())
                                .font(.custom("Helvetica", fixedSize: 14))
                                .foregroundColor(.gray)
                            Text(cryptoQuote.currency)
                                .font(.custom("Helvetica", fixedSize: 12))
                                .foregroundColor(.gray)
                        }
                    }.frame(width: geometry.size.width * 0.3, alignment: .trailing)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                }.padding(.horizontal, 6)
            
            
            )
        }
        .frame(height: 64, alignment: .center)
    }
}

struct StockSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        let stockSymbol = StockSymbolModel()
        CryptoSymbolView(cryptoSymbol: stockSymbol.cryptoSymbol, cryptoQuote: CryptoQuote(stockSymbol.cryptoSymbol.cadQuote))
            .preferredColorScheme(.dark)
        StockSymbolView(stock: stockSymbol.symbols[1])
            .preferredColorScheme(.dark)
        
    }
}
