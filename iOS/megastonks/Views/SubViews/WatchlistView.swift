//
//  WatchlistView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-03.
//

import SwiftUI

struct WatchlistView: View {
    var stocks:StockSymbolModel = StockSymbolModel()
    var body: some View {
        ScrollView(.vertical) {
            VStack{
                StockSymbolView(stock: stocks.symbols[0])
                //StockSymbolView(stock: stocks.symbols[1])
            }
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
            .preferredColorScheme(.dark)
    }
}
}
