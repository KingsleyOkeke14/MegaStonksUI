//
//  OrderView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-13.
//

import SwiftUI

struct OrderView: View {
    let myColors = MyColors()
    
    var orderHistoryElement: OrderHistoryElement
    var shareText:String = "Shares"
    
    @State var showDetailView:Bool = false
    
    init(orderHistoryElement: OrderHistoryElement){
        self.orderHistoryElement = orderHistoryElement
        self.shareText = orderHistoryElement.quantityFilled <= 1.0 ? "Share" : "Shares"
    }
    
    var body: some View {
        Button(action: {
            showDetailView.toggle()
        }, label: {
            VStack(spacing: 2){
                HStack{
                    Text(orderHistoryElement.symbol)
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 20))
                        .bold()
                    Text(orderHistoryElement.name)
                        .font(.custom("Verdana", fixedSize: 10))
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }
                
                HStack{
                    Text("\(orderHistoryElement.orderAction) \(orderHistoryElement.quantityFilled.formatNoDecimal()) \(shareText) x $\(orderHistoryElement.pricePerShare.formatPrice())")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 16))
                    Spacer()
                    Text("@\(orderHistoryElement.orderType)")
                        .foregroundColor(myColors.lightGrayColor)
                        .font(.custom("Verdana", fixedSize: 16))
                        
                }
                if(orderHistoryElement.orderAction.uppercased() == "BUY"){
                    HStack{
                        Spacer()
                        Text("-$\(orderHistoryElement.totalCost.formatPrice())")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 16))
                    }
                }
                else if(orderHistoryElement.orderAction.uppercased() == "SELL"){
                    HStack{
                        Spacer()
                        Text("+$\((orderHistoryElement.totalPriceFilled - orderHistoryElement.commission).formatPrice())")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 16))
                    }
                }
             
                
                HStack{
                    Text("\(orderHistoryElement.orderStatus)")
                        .foregroundColor(myColors.greenColor)
                        .font(.custom("Verdana", fixedSize: 12))
                    Spacer()
                    Text("\(orderHistoryElement.dateFilled)")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 12))
                }
                Rectangle()
                    .fill(Color(.gray))
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)
            }.lineLimit(1).minimumScaleFactor(0.5).padding(.horizontal)
        }).sheet(isPresented: $showDetailView) {
            OrderDetailView(orderHistoryElement: orderHistoryElement).preferredColorScheme(.dark)
            }
    }
    
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(orderHistoryElement: StockSymbolModel().orderHistoryElement).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
