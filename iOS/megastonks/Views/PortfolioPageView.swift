//
//  PortfolioPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-10.
//

import SwiftUI

struct PortfolioPageView: View {
    var stocks:StockSymbolModel = StockSymbolModel()
    let myColors = MyColors()
    
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack(spacing: 30){
                    Image("megastonkslogo")
                        .scaleEffect(0.6)
                        .aspectRatio(contentMode: .fit)
                    PortfolioSummaryView()
                    HStack {
                        Text("Holdings")
                                .font(.title2)
                                .bold()
                                .foregroundColor(myColors.greenColor)
                            .padding(.top)
                        Spacer()
                    }.padding(.horizontal)
                           
                            
                        
                    ScrollView(.vertical) {
                        VStack{
                            ForEach(0..<stocks.symbols.count){
                                StockSymbolView(stock: stocks.symbols[$0])
                            }
                        }
                    }
                }
                
            )
        
        
        
        
    }
}

struct PortfolioPageView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioPageView()
    }
}
