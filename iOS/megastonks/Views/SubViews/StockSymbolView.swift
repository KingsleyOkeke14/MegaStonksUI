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
                VStack(spacing: 10) {
                        
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
                                    if(stock.change >= 0){
                                        Text("P")
                                            .font(.custom("Arial Bold", fixedSize:8))
                                            .foregroundColor(.black)
                                            .padding(2)
                                            .padding(.horizontal, 2)
                                            .background(myColors.greenColor)
                                            .cornerRadius(30)
                                    }
                                    else{
                                        Text("P")
                                            .font(.custom("Arial Bold", fixedSize:8))
                                            .foregroundColor(.black)
                                            .padding(2)
                                            .padding(.horizontal, 2)
                                            .background(myColors.redColor)
                                            .cornerRadius(30)
                                    }
                                }
                                
                            }.frame(width: geometry.size.width * 0.3, alignment: .leading)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            

                            Spacer()
                            VStack(spacing: 4){
                                if(stock.change >= 0){
                                    Image(systemName: "arrow.up.circle.fill")
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                        .foregroundColor(.green)
                                        .scaleEffect(1.4)
                                }
                                else{
                                    Image(systemName:  "arrow.down.circle.fill")
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                        .foregroundColor(.red)
                                        .scaleEffect(1.4)
                                }
                                    
                                if(stock.change >= 0){
                                    Text(String("(" +  stock.changesPercentage.formatPercentChange() + "%)"))
                                        .font(.custom("Helvetica", fixedSize: 14))
                                        .foregroundColor(.green)
                                    
                                }
                                else{
                                    Text(String("(" +  stock.changesPercentage.formatPercentChange() + "%)"))
                                        .font(.custom("Helvetica", fixedSize: 14))
                                        .foregroundColor(.red)
                                }
                                    
                                
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
                        }
                        Rectangle()
                            .fill(Color(.gray))
                            .frame(height: 2)
                            .edgesIgnoringSafeArea(.horizontal)
                            
                        
                        
                    }
            }
            .frame(height: 54, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct StockSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        let stockSymbol = StockSymbolModel()
        StockSymbolView(stock: stockSymbol.symbols[1])
            .preferredColorScheme(.dark)
        
    }
}
