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
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        
        // this overrides everything you have set up earlier.
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .black
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        // to make everything work normally
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UINavigationBar.appearance().tintColor = .green
    }
    
    var body: some View {
        NavigationView{
            Color.black
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                VStack(spacing: 1){
                    PortfolioSummaryView()
                    HStack {
                        Text("Holdings")
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                .bold()
                                .foregroundColor(myColors.greenColor)
                        Spacer()
                    }.padding(.horizontal)
                           
                            
                        
                    ScrollView(.vertical) {
                        VStack{
                            ForEach(0..<stocks.symbols.count){
                                StockSymbolView(stock: stocks.symbols[$0])
                            }
                        }
                    }.padding()
                }
                
            )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        
        
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct PortfolioPageView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioPageView()
    }
}
