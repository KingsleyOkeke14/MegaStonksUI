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
                VStack(spacing: 20){
                    PortfolioSummaryView().padding(.top, 10)
                    HStack {
                        Text("Holdings")
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
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
