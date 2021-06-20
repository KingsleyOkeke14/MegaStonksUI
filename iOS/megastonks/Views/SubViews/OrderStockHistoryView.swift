//
//  OrderView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-13.
//

import SwiftUI

struct OrderStockHistoryView: View {
    let myColors = MyColors()
    
    var orderHistoryElement: OrderStockHistoryElement
    var shareText:String = "Shares"
    
    @State var showDetailView:Bool = false
    
    init(orderHistoryElement: OrderStockHistoryElement){
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
                        .font(.custom("Verdana", fixedSize: 12))
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
                    Text("\(orderHistoryElement.dateFilled.getTimeInterval())")
                        .foregroundColor(.gray)
                        .font(.custom("Verdana", fixedSize: 12))
                }
                Rectangle()
                    .fill(Color(.gray))
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)
            }.lineLimit(1).minimumScaleFactor(0.5).padding(.horizontal)
        }).sheet(isPresented: $showDetailView) {
            OrderHistoryStockDetailPageView(orderHistoryElement: orderHistoryElement).preferredColorScheme(.dark)
            }
    }
    
}

struct OrderCryptoHistoryView: View {
    let myColors = MyColors()
    
    var orderHistoryElement: OrderCryptoHistoryElement
    var shareText:String = "Units"
    
    @State var showDetailView:Bool = false
    
    init(orderHistoryElement: OrderCryptoHistoryElement){
        self.orderHistoryElement = orderHistoryElement
        self.shareText = orderHistoryElement.quantityFilled <= 1.0 ? "Unit" : "Units"
    }
    
    var body: some View {
        Button(action: {
            showDetailView.toggle()
        }, label: {
            VStack(spacing: 2){
                HStack{
                    Text(orderHistoryElement.cryptoSymbol)
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
                    Text("\(orderHistoryElement.orderAction) \(orderHistoryElement.quantityFilled.formatPrice()) \(shareText) @ $\(orderHistoryElement.pricePerShare.formatPrice()) per unit")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 12))
                    Spacer()
                    Text("@\(orderHistoryElement.orderType)")
                        .foregroundColor(myColors.lightGrayColor)
                        .font(.custom("Verdana", fixedSize: 16))
                        
                }
                if(orderHistoryElement.orderAction.uppercased() == "BUY"){
                    HStack{
                        AsyncImage(url: URL(string: orderHistoryElement.logo)!,
                                   placeholder: { Image("blackImage") },
                                   image: { Image(uiImage: $0).resizable() })
                            .frame(width: 20, height: 20, alignment: .center)
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .shadow(radius: 8)
                        Spacer()
                        Text("-$\(orderHistoryElement.totalCost.formatPrice())")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 16))
                    }
                }
                else if(orderHistoryElement.orderAction.uppercased() == "SELL"){
                    HStack{
                        AsyncImage(url: URL(string: orderHistoryElement.logo)!,
                                   placeholder: { Image("blackImage") },
                                   image: { Image(uiImage: $0).resizable() })
                            .frame(width: 20, height: 20, alignment: .center)
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fill)
                            .shadow(radius: 8)
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
                    Text("\(orderHistoryElement.dateFilled.getTimeInterval())")
                        .foregroundColor(.gray)
                        .font(.custom("Verdana", fixedSize: 12))
                }
                Rectangle()
                    .fill(Color(.gray))
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)
            }.lineLimit(1).minimumScaleFactor(0.5).padding(.horizontal)
        }).sheet(isPresented: $showDetailView) {
             OrderHistoryCryptoDetailPageView(orderHistoryElement: orderHistoryElement).preferredColorScheme(.dark)
            }
    }
    
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderStockHistoryView(orderHistoryElement: StockSymbolModel().orderHistoryElement).preferredColorScheme(.dark)
        OrderCryptoHistoryView(orderHistoryElement: StockSymbolModel().orderCryptoHistoryElement).preferredColorScheme(.dark)
    }
}
