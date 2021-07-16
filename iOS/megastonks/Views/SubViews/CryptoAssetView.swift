//
//  CryptoAssetView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-07-06.
//

import SwiftUI

struct CryptoAssetView: View {
    
    //MARK: Properties
    let myColors = MyColors()
    var cryptoSymbol:CryptoSymbol
    var cryptoQuote: CryptoQuote
    
    
    var body: some View {
        
        VStack {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(myColors.grayColor)
                VStack(spacing: 1){
                    HStack{
                        AsyncImage(url: URL(string: cryptoSymbol.info.logo)!, placeholder: {
                            Image("blackImage")
                        }, image: {
                            Image(uiImage: $0).resizable()
                        })
                        .frame(width: 60, height: 60, alignment: .center)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .shadow(radius: 8)
                        
                        VStack{
                            Text(cryptoSymbol.crypto.name)
                                .bold()
                            HStack{
                                Image(systemName: cryptoQuote.percentChange24H >= 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                                    .foregroundColor(cryptoQuote.percentChange24H >= 0 ? .green : .red)
                                
                                Text("(\(cryptoQuote.percentChange24H.formatPercentChange())%)")
                                    .foregroundColor(cryptoQuote.percentChange24H >= 0 ? .green : .red)
                            }
                            HStack{
                                Text("$\(cryptoQuote.price.formatPrice())")
                                    .bold()
                            }
                        }
                    }
                }
            }
        }.frame(width: 180, height: 80, alignment: .center)
      
    }
}

struct CryptoHomeView : View {
    
    //MARK: Properties
    
    let model = StockSymbolModel()
    var body: some View{
        VStack{
            ScrollView(.horizontal){
                HStack(spacing: 20){
                    CryptoAssetView(cryptoSymbol: model.cryptoSymbol, cryptoQuote: CryptoQuote(model.cryptoSymbol.cadQuote))
                    CryptoAssetView(cryptoSymbol: model.cryptoSymbol2, cryptoQuote: CryptoQuote(model.cryptoSymbol2.cadQuote))
                    CryptoAssetView(cryptoSymbol: model.cryptoSymbol, cryptoQuote: CryptoQuote(model.cryptoSymbol.cadQuote))
                    CryptoAssetView(cryptoSymbol: model.cryptoSymbol2, cryptoQuote: CryptoQuote(model.cryptoSymbol2.cadQuote))
                }
            }
         
        }
    }
}

struct CryptoAssetView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        
       let model = StockSymbolModel()
        
        CryptoHomeView().preferredColorScheme(.dark)
        
        
        CryptoAssetView(cryptoSymbol: model.cryptoSymbol, cryptoQuote: CryptoQuote(model.cryptoSymbol.cadQuote)).preferredColorScheme(.dark)
        
        
    }
}
