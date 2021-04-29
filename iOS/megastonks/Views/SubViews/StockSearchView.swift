//
//  SearchStockView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-27.
//

import SwiftUI

struct StockSearchView: View {
    
    let myColors = MyColors()
    
    var stock:StockSearchResult
    
    var body: some View {
        VStack(spacing: 0.5){
            HStack {
                VStack(alignment: .leading){
                    Text(stock.symbol)
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                        .bold()
                        .foregroundColor(.white)
                    Text(stock.companyName)
                        .font(.custom("Helvetica", fixedSize: 14))
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing){
                    Text(stock.country)
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                        .bold()
                        .foregroundColor(.white)
                    Text(stock.exchangeShortName)
                        .font(.custom("Helvetica", fixedSize: 14))
                        .foregroundColor(.gray)
                }
            }
            Rectangle()
                .fill(Color(.gray))
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
    
        }
        .lineLimit(1)
        .minimumScaleFactor(0.8)
    }
}

struct SearchStockView_Previews: PreviewProvider {
    static var previews: some View {
        StockSearchView(stock: StockSymbolModel().stockSearch[1])
            .preferredColorScheme(.dark)
    }
}
