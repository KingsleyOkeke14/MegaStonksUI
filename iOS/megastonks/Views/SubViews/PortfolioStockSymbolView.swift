//
//  PorfolioStockView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-02.
//

import SwiftUI

struct PortfolioStockSymbolView: View {
    
    let myColors = MyColors()
    
    var holding:StockHolding
    
    @Binding var isAllTimeGains:Bool
    
    var body: some View {
            GeometryReader { geometry in
                VStack(spacing: 10) {
                        
                        HStack{
                            HStack {
                                VStack(alignment: .leading){
                                    Text(holding.symbol)
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                        .bold()
                                        .foregroundColor(.white)
                                    Text("\(holding.quantity.formatNoDecimal()) Shares")
                                        .font(.custom("Helvetica", fixedSize: 14))
                                        .foregroundColor(.gray)
                                }
                                
                            }.frame(width: geometry.size.width * 0.3, alignment: .leading)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            

                            Spacer()
                            VStack(spacing: 4){
                                
                                if(!isAllTimeGains){
                                    Image(systemName: holding.percentReturnToday >= 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                        .foregroundColor(holding.percentReturnToday >= 0 ? .green : .red)
                                        .scaleEffect(1.4)
                        
                                   Text(String("(" +  holding.percentReturnToday.formatPercentChange() + "%)"))
                                        .font(.custom("Helvetica", fixedSize: 14))
                                        .foregroundColor(holding.percentReturnToday >= 0 ? .green : .red)
                                }
                                else{
                                    Image(systemName: holding.percentReturnTotal >= 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                        .foregroundColor(holding.percentReturnTotal >= 0 ? .green : .red)
                                        .scaleEffect(1.4)
                        
                                    Text(String("(" +  holding.percentReturnTotal.formatPercentChange() + "%)"))
                                        .font(.custom("Helvetica", fixedSize: 14))
                                        .foregroundColor(holding.percentReturnTotal >= 0 ? .green : .red)
                                }

 
                            }.frame(width: geometry.size.width * 0.3, alignment: .center)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            Spacer()
                            
                            VStack(alignment: .trailing){
                                Text("$" + holding.marketValue.formatPrice())
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                    .bold()
                                    .foregroundColor(.white)
                                HStack{
                                    if(!isAllTimeGains){
                                        Text(holding.moneyReturnToday.formatPrice())
                                            .font(.custom("Helvetica", fixedSize: 14))
                                            .foregroundColor(.gray)
                                    }
                                    else{
                                        Text(holding.moneyReturnTotal.formatPrice())
                                            .font(.custom("Helvetica", fixedSize: 14))
                                            .foregroundColor(.gray)
                                    }
  
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

struct PortfolioStockView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioStockSymbolView(holding: StockSymbolModel().stockHolding, isAllTimeGains: Binding.constant(false)).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
