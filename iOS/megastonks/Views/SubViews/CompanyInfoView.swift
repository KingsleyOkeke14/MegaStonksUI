//
//  CompanyInfoView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-10.
//

import SwiftUI

struct CompanyInfoView: View {
    let myColors = MyColors()
    @Binding var stockSymbol: StockSymbol
    @Binding var themeColor: Color
    
    var body: some View {
            
            
        if(!stockSymbol.description.isEmpty){
            VStack(alignment: .leading, spacing: 2){
                Text("Company Information")
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                    .bold()
                    .foregroundColor(themeColor)
                    .padding(.top)
                
                Rectangle()
                    .fill(myColors.lightGrayColor)
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)
                Text(stockSymbol.description)
                    .foregroundColor(.white)
                    .font(.custom("Verdana", fixedSize: 14))
                
            }.padding()
        }

            
    }
}

struct CompanyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyInfoView(stockSymbol: Binding.constant(StockSymbolModel().symbols[1]), themeColor: Binding.constant(Color.red))
            .preferredColorScheme(.dark)
    }
}
