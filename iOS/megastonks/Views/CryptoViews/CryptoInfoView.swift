//
//  CryptoInfoView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-18.
//

import SwiftUI

struct CryptoInfoView: View {
    let myColors = MyColors()
    
    var defaultCurrency: String
    @Binding var cryptoSymbol: CryptoSymbol
    
    @Binding var highlightColor:Color
    
    @State var currentCurrency: String
    
    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
    
    init(defaultCurrency:String, cryptoSymbol: Binding<CryptoSymbol>, highlightColor: Binding<Color>) {
        self.defaultCurrency = defaultCurrency
        _currentCurrency = State.init(initialValue: defaultCurrency)
        self._cryptoSymbol = cryptoSymbol
        self._highlightColor = highlightColor
    }
    var body: some View {
        HStack{
            VStack(spacing: 2){
                ZStack{
                    Circle()
                        .stroke(highlightColor, lineWidth: 4)
                        .frame(width: 80, height: 80)
                        .shadow(color: highlightColor, radius: 6, x: 4, y: 4)
                    AsyncImage(url: URL(string: cryptoSymbol.info.logo)!,
                               placeholder: { Image("blackImage") },
                               image: { Image(uiImage: $0).resizable() })
                        .frame(width: 80, height: 80, alignment: .center)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .shadow(radius: 8)
                }
                
                
                Text("(\(cryptoSymbol.crypto.symbol)) \(cryptoSymbol.crypto.name)")
                    .font(.custom("Helvetica", fixedSize: 18))
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                HStack {
                    Text(currentCurrency == "USD" ? "\(cryptoSymbol.usdQuote.price.formatPrice())" : "\(cryptoSymbol.cadQuote.price.formatPrice())")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 24))
                        .bold()
                        +
                        Text(" \(currentCurrency)")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 16))
                        .bold()
                        .baselineOffset(0)
                    
                    VStack {
                        Button(action: {
                            impactMed.impactOccurred()
                            toggleCurrentCurrency()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                withAnimation {
                                    if(defaultCurrency != currentCurrency){
                                        currentCurrency = defaultCurrency
                                    }
                                }
                            }
                            
                        }, label: {
                            Text(currentCurrency == "USD" ? "🇺🇸" : "🇨🇦")
                                .font(.custom("Marker Felt", fixedSize: 16))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .background(myColors.darkGrayColor)
                                .cornerRadius(20)
                                .shadow(color: highlightColor, radius: 2, x: 1, y: -1)
                        })
                    }
                }
            }
        }
    }
    
    func toggleCurrentCurrency(){
        if(currentCurrency == "USD"){
            currentCurrency = "CAD"
        }
        else if(currentCurrency == "CAD"){
            currentCurrency = "USD"
        }
    }
}

struct CryptoInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoInfoView(defaultCurrency: "CAD", cryptoSymbol: Binding.constant(StockSymbolModel().cryptoSymbol), highlightColor: Binding.constant(Color.init(red: 255/255, green: 0/255, blue: 0/255))).preferredColorScheme(.dark)
    }
}
