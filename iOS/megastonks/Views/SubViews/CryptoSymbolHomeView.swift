//
//  CryptoSymbolHomeView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-06-14.
//

import SwiftUI

struct CryptoSymbolHomeView: View {
    
    
   let myColors = MyColors()
   var cryptoSymbol:CryptoSymbol
   var cryptoQuote: CryptoQuote
    
    var body: some View {
        VStack{
            ZStack(alignment: .topLeading){
                RoundedRectangle(cornerRadius: 20)
                    .fill(myColors.grayColor)
                    
                VStack(spacing: 1) {
                    HStack{
                        AsyncImage(url: URL(string: cryptoSymbol.info.logo)!,
                                   placeholder: { Image("blackImage") },
                                   image: { Image(uiImage: $0).resizable() })
                            .frame(width: 60, height: 60, alignment: .center)
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .shadow(radius: 8)
                            .padding(.top, 6)
                            .padding(.leading, 8)
                        VStack(alignment: .leading){
                            Text(cryptoSymbol.crypto.name)
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                .bold()
                                .foregroundColor(.white)
                            
                            HStack {
                                Image(systemName: cryptoQuote.percentChange24H >= 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                    .foregroundColor(cryptoQuote.percentChange24H >= 0 ? .green : .red)
                                    .scaleEffect(1.4)
                                
                                Text(String("(" +  cryptoQuote.percentChange24H.formatPercentChange() + "%)"))
                                    .font(.custom("Helvetica", fixedSize: 14))
                                    .foregroundColor(cryptoQuote.percentChange24H >= 0 ? .green : .red)
                                Spacer()
                            }
                            Text("Past Hour")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                .bold()
                                .foregroundColor(.gray)
                        }
                    }
                    HStack{
                        //Spacer()
                            Text("$" + cryptoQuote.price.formatPrice())
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.leading, 46)
                    }
                }
            }
        }.frame(width: 180, height: 80, alignment: .center)
    }
}

struct CryptoSymbolHomeView_Previews: PreviewProvider {
    static var previews: some View {
        let stockSymbol = StockSymbolModel()
        CryptoSymbolHomeView(cryptoSymbol: stockSymbol.cryptoSymbol, cryptoQuote: CryptoQuote(stockSymbol.cryptoSymbol.cadQuote)).preferredColorScheme(.dark)
    }
}
