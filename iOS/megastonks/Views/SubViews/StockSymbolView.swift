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
                            Text(stock.symbol)
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                .bold()
                                .foregroundColor(.white)
                            Text(stock.exchange)
                                .font(.custom("Helvetica", fixedSize: 14))
                                .foregroundColor(.gray)
                        }.frame(width: 120, height: 40, alignment: .leading)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        VStack{
                            if(stock.isInPortfolio){
                            Text("P")
                                .font(.custom("Arial Bold", fixedSize:8))
                                .foregroundColor(.black)
                                .padding(2)
                                .padding(.horizontal, 2)
                                .background(myColors.greenColor)
                                .cornerRadius(20)
                            }
                        }
                        Spacer()
                        VStack(spacing: 4){
                            if(isStockGaining()){
                                Image(systemName:  "arrow.up.circle.fill")
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                    .foregroundColor(.green)
                                    .scaleEffect(1.4)
                            }
                            else
                            {
                                Image(systemName:  "arrow.down.circle.fill")
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                    .foregroundColor(.red)
                                    .scaleEffect(1.4)
                            }
                                
                            if(isStockGaining()){
                                Text(String("(" +  formatChange(stock.changesPercentage) + "%)"))
                                    .font(.custom("Helvetica", fixedSize: 14))
                                    .foregroundColor(.green)
                                
                            }
                            else{
                                Text(String("(" +  formatChange(stock.changesPercentage) + "%)"))
                                    .font(.custom("Helvetica", fixedSize: 14))
                                    .foregroundColor(.red)
                            }
                                
                            
                        }.frame(width: 80, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        Spacer()
                        VStack(alignment: .trailing){
                            Text("$" + formatDouble(stock.price))
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                .bold()
                                .foregroundColor(.white)
                            HStack{
                                Text(formatChange(stock.change))
                                    .font(.custom("Helvetica", fixedSize: 14))
                                    .foregroundColor(.gray)
                                Text(String(stock.currency))
                                    .font(.custom("Helvetica", fixedSize: 12))
                                    .foregroundColor(.gray)
                            }
                        }.frame(width: 120, height: 40, alignment: .trailing)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    }
                    Rectangle()
                        .fill(Color(.gray))
                        .frame(height: 2)
                        .edgesIgnoringSafeArea(.horizontal)
                        
                    
                    
                }
//            )
    }
    
    func isStockGaining() -> Bool {
        
        return stock.change > 0 ? true : false
    }
    
    func formatDouble(_ number:Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        return  numberFormatter.string(from: NSNumber(value: number))!
        
    }
    
    func formatChange(_ number:Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.positivePrefix = numberFormatter.plusSign
        
        return  numberFormatter.string(from: NSNumber(value: number))!
        
    }
}

struct StockSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        let stockSymbol = StockSymbolModel()
        StockSymbolView(stock: stockSymbol.symbols[0])
            .preferredColorScheme(.dark)
        
    }
}
