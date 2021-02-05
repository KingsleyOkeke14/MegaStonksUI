//
//  StockSymbolView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-03.
//

import SwiftUI

struct StockSymbolView: View {
    let grayColor:Color = Color.init(red: 198/255, green: 197/255, blue: 197/255)
    
    let greenColor:Color = Color.init(red: 72/255, green: 175/255, blue: 56/255)
    
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
                                .foregroundColor(grayColor)
                        }
                        Spacer()
                        VStack{
                            Image(stock.isGaining ? "arrowUp" : "arrowDown")
                                .scaleEffect(1.4)
                            Text(String("(" + getSignal() +  formatDouble(stock.percentChange) + "%)"))
                                .font(.custom("Helvetica", size: 14))
                                .foregroundColor(greenColor)
                            
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
                                    .foregroundColor(grayColor)
                                Text(String(stock.currency))
                                    .font(.custom("Helvetica", size: 14))
                                    .foregroundColor(grayColor)
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
