//
//  WatchListPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-03.
//

import SwiftUI

struct WatchListPageView: View {
    
    let myColors = MyColors()
    @State var searchText:String
    
    var stocks:StockSymbolModel = StockSymbolModel()
    
    var body: some View {
        Color.black
            .ignoresSafeArea() // Ignore just for the color
            .overlay(
                
                VStack{
                    Image("megastonkslogo")
                        .scaleEffect(0.6)
                        .aspectRatio(contentMode: .fit)
                    SearchBarView(text: $searchText)
                    HStack{
                        Text("Watchlist")
                            .font(.custom("Apple SD Gothic Neo", size: 22))
                            .fontWeight(.heavy)
                            .bold()
                            .foregroundColor(myColors.greenColor)
                        Image(systemName: "eye")
                            .foregroundColor(myColors.greenColor)
                            .font(.headline)
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    
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

struct WatchListPageView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListPageView(searchText: "")
        
        
    }
}
