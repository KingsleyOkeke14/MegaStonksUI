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
//        Color.black
//            .ignoresSafeArea() // Ignore just for the color
//            .overlay(
                VStack {
                    HStack{
                        VStack(alignment: .leading){
                            Text(stock.tickerSymbol)
                                .font(.custom("Apple SD Gothic Neo", size: 20))
                                .bold()
                                .foregroundColor(.white)
                            Text(stock.exchange)
                                .font(.custom("Helvetica", size: 14))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack{
                            Image(stock.isGaining ? "arrowUp" : "arrowDown")
                                .scaleEffect(1.4)

                            if(getSignal() == "+"){
                                Text(String("(" + getSignal() +  formatDouble(stock.percentChange) + "%)"))
                                    .font(.custom("Helvetica", size: 14))
                                    .foregroundColor(.green)
                            }
                            else{
                                Text(String("(" + getSignal() +  formatDouble(stock.percentChange) + "%)"))
                                    .font(.custom("Helvetica", size: 14))
                                    .foregroundColor(.red)
                            }
                                
                            
                        }
                        Spacer()
                        VStack(alignment: .trailing){
                            Text("$" + formatDouble(stock.price))
                                .font(.custom("Apple SD Gothic Neo", size: 20))
                                .bold()
                                .foregroundColor(.white)
                            HStack{
                                Text(getSignal() + formatDouble(stock.dollarChange))
                                    .font(.custom("Helvetica", size: 14))
                                    .foregroundColor(.gray)
                                Text(String(stock.currency))
                                    .font(.custom("Helvetica", size: 14))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    Rectangle()
                        .fill(Color(.gray))
                        .frame(height: 2)
                        .edgesIgnoringSafeArea(.horizontal)
                        
                    
                    
                }.padding(.horizontal)
//            )
    }
    
    func getSignal() -> String {
        return stock.isGaining ? "+" : ""
    }
    
    func formatDouble(_ number:Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        return  numberFormatter.string(from: NSNumber(value: number))!
        
    }
}

struct StockSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        StockSymbolView(stock: StockSymbolModel().symbols[0])
            .preferredColorScheme(.dark)
        
    }
}
