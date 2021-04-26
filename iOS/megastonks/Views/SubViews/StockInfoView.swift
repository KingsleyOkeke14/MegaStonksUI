//
//  StockInfoView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-04.
//

import SwiftUI

struct StockInfoView: View {
    
    let mycolors = MyColors()
    
    @Binding var stockSymbol: StockSymbol
    
    var body: some View {
        HStack{
            VStack(spacing: 2){
                
                
                ZStack{
                    Circle()
                        .stroke(Color.green, lineWidth: 4)
                        .frame(width: 80, height: 80)
                        .shadow(color: Color.green, radius: 6, x: 4, y: 4)
                    Circle()
                        .fill(mycolors.grayColor)
                        .frame(width: 80, height: 80)
                    Text(stockSymbol.symbol)
                        .font(.custom("Helvetica", fixedSize: 20))
                        .bold()
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding()
                }
                
                Text(stockSymbol.name)
                    .font(.custom("Helvetica", fixedSize: 18))
                    .foregroundColor(.white)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                
                HStack {
                    Text(stockSymbol.price.formatPrice())
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 24))
                        .bold()
                        +
                        Text(" CAD")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 18))
                        .bold()
                        .baselineOffset(0)
                    
                }
                
            }
        }
    }
}


struct StockInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StockInfoView(stockSymbol: Binding.constant(StockSymbolModel().symbols[0]))
            .preferredColorScheme(.dark)
    }
}
