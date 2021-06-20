//
//  OderCryptoDetailPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-06-19.
//

import SwiftUI

struct OrderHistoryCryptoDetailPageView: View {
    
    let myColors = MyColors()
    var orderHistoryElement: OrderCryptoHistoryElement?
    var unitText = "Units"
    
    init(orderHistoryElement: OrderCryptoHistoryElement){
        self.orderHistoryElement = orderHistoryElement
        self.unitText = orderHistoryElement.quantityFilled <= 1.0 ? "Unit" : "Units"
    }
    
    
    var body: some View {
        ScrollView{
            Spacer(minLength: 20)
                VStack(spacing: 20){

                    HStack{
                        Text(orderHistoryElement!.orderStatus)
                            .foregroundColor(myColors.greenColor)
                            .font(.custom("Verdana", fixedSize: 20))
                            .bold()
                    }
                    HStack{
                            AsyncImage(url: URL(string: orderHistoryElement!.logo)!,
                                       placeholder: { Image("blackImage") },
                                       image: { Image(uiImage: $0).resizable() })
                                .frame(width: 80, height: 80, alignment: .center)
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fill)
                                .shadow(radius: 8)
                    }
                    Text("\(orderHistoryElement!.name) (\(orderHistoryElement!.cryptoSymbol))")
                        .font(.custom("Helvetica", fixedSize: 18))
                        .foregroundColor(.white)
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    TripleRowView(label1: "Order Type", value1: orderHistoryElement!.orderType, label2: "Status", value2: orderHistoryElement!.orderStatus, label3: "Action", value3: orderHistoryElement!.orderAction)
                    DoubleRowView(label1: "Date Submitted", value1: orderHistoryElement!.dateSubmitted.toDateTimeFormat(), label2: "Date Filled", value2: orderHistoryElement!.dateFilled.toDateTimeFormat())
                    DoubleRowView(label1: "Qty Submitted", value1: "\(orderHistoryElement!.quantitySubmitted.formatPrice()) \(unitText)", label2: "Qty Filled", value2: "\(orderHistoryElement!.quantityFilled.formatPrice()) \(unitText)")
                    SingleRowView(label: "Commission", value: "$\(orderHistoryElement!.commission)")
                    DoubleRowView(label1: "", value1: "\(orderHistoryElement!.quantityFilled.formatPrice()) \(unitText) @ $\(orderHistoryElement!.pricePerShare.formatPrice()) per unit", label2: "Price Filled", value2: "$\(orderHistoryElement!.totalPriceFilled.formatPrice())")
                    if(orderHistoryElement!.orderAction.uppercased() == "BUY"){
                        SingleRowView(label: "Total Cost", value: "$\(orderHistoryElement!.totalCost.formatPrice())")
                    }
                    else if(orderHistoryElement!.orderAction.uppercased() == "SELL"){
                        SingleRowView(label: "Total Value", value: "$\((orderHistoryElement!.totalCost - orderHistoryElement!.commission).formatPrice())")
                    }

                }.lineLimit(1).minimumScaleFactor(0.5)
        }
   }
}

struct OrderHistoryCryptoDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryCryptoDetailPageView(orderHistoryElement: StockSymbolModel().orderCryptoHistoryElement)
            .preferredColorScheme(.dark)
    }
}
