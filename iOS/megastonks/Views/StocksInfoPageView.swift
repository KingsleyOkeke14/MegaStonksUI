//
//  StocksInfoPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-08.
//

import SwiftUI
import SwiftUICharts

struct StocksInfoPageView: View {
    
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack(spacing: 2){
                    StockInfoView()
                    ScrollView{
                        VStack{
                            ChartView(chartButtonList: [("1D", true), ("5D", false), ("1M", false), ("3M", false), ("1Y", false), ("5Y", false)])
                            MyHoldingsView()
                            StatisticsView()
                            CompanyInfoView()
                        }
                        
                    }
                    
                }
            )
        
    }
}

struct StocksInfoPageView_Previews: PreviewProvider {
    static var previews: some View {
        StocksInfoPageView()
    }
}
