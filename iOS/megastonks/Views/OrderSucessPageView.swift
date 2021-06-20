//
//  OrderSucessPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-03.
//

import SwiftUI

struct OrderSucessPageView: View {
        
        var isCrypto: Bool
        var orderStockResult: OrderStockResultInfo?
        var orderCryptoResult: OrderCryptoResultInfo?
        var shareText = "Shares"
        var unitText = "Units"
        
    init(isCrypto: Bool, orderStockResult: OrderStockResultInfo?, orderCryptoResult: OrderCryptoResultInfo?){
            self.isCrypto = isCrypto
            self.orderStockResult = orderStockResult
            self.orderCryptoResult = orderCryptoResult
            self.shareText = orderStockResult?.quantityFilled ?? 0.0 <= 1.0 ? "Share" : "Shares"
            self.unitText = orderCryptoResult?.quantityFilled ?? 0.0 <= 1.0 ? "Unit" : "Units"
        }
        
        let myColors = MyColors()
        var body: some View {
            Color.black
                .ignoresSafeArea()
                .overlay(
                    ScrollView{
                        Spacer(minLength: 20)
                        if(!isCrypto && orderStockResult != nil){
                            VStack(spacing: 20){
                                
                                HStack{
                                    Text(orderStockResult!.orderStatus)
                                        .foregroundColor(myColors.greenColor)
                                        .font(.custom("Verdana", fixedSize: 20))
                                        .bold()
                                }
                                HStack{
                                    ZStack{
                                        Circle()
                                            .stroke(myColors.greenColor, lineWidth: 4)
                                            .frame(width: 80, height: 80)
                                            .shadow(color: myColors.greenColor, radius: 6, x: 4, y: 4)
                                        Circle()
                                            .fill(myColors.grayColor)
                                            .frame(width: 80, height: 80)
                                        Text(orderStockResult!.stockSymbol)
                                            .font(.custom("Verdana", fixedSize: 20))
                                            .bold()
                                            .foregroundColor(.white)
                                            .frame(width: 80, height: 80, alignment: .center)
                                            .padding()
                                    }

                                }

                                
                                Text(orderStockResult!.name)
                                    .font(.custom("Verdana", fixedSize: 16))
                                    .foregroundColor(.white)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                
                                TripleRowView(label1: "Order Type", value1: orderStockResult!.orderType, label2: "Status", value2: orderStockResult!.orderStatus, label3: "Action", value3: orderStockResult!.orderAction)
                                DoubleRowView(label1: "Date Submitted", value1: orderStockResult!.dateSubmitted.toDateTimeFormatShort(), label2: "Date Filled", value2: orderStockResult!.dateFilled.toDateTimeFormatShort())
                                DoubleRowView(label1: "Qty Submitted", value1: "\(orderStockResult!.quantitySubmitted.formatNoDecimal()) \(shareText)", label2: "Qty Filled", value2: "\(orderStockResult!.quantityFilled.formatNoDecimal()) \(shareText)")
                                SingleRowView(label: "Commission", value: "$\(orderStockResult!.commission)")
                                TripleRowView(label1: "Currency", value1: "\(orderStockResult!.currency)", label2: "Forex Exchange", value2: "\(orderStockResult!.forexExchangeRate.formatForex())", label3: "Amount Exchanged", value3: "\(orderStockResult!.exchangeResult.formatForex())")
                                DoubleRowView(label1: "", value1: "\(orderStockResult!.quantityFilled.formatNoDecimal()) \(shareText) x $\(orderStockResult!.pricePerShare.formatPrice())", label2: "Price Filled", value2: "$\(orderStockResult!.totalPriceFilled.formatPrice())")
                                if(orderStockResult!.orderAction.uppercased() == "BUY"){
                                    SingleRowView(label: "Total Cost", value: "$\(orderStockResult!.totalCost.formatPrice())")
                                }
                                else if(orderStockResult!.orderAction.uppercased() == "SELL"){
                                    SingleRowView(label: "Total Value", value: "$\((orderStockResult!.totalCost - orderStockResult!.commission).formatPrice())")
                                }
                              
                            }.lineLimit(1).minimumScaleFactor(0.5)
                        }
                        else if (isCrypto && orderCryptoResult != nil){
                            VStack(spacing: 20){
                                
                                HStack{
                                    Text(orderCryptoResult!.orderStatus)
                                        .foregroundColor(myColors.greenColor)
                                        .font(.custom("Verdana", fixedSize: 20))
                                        .bold()
                                }
                                HStack{
                                        AsyncImage(url: URL(string: orderCryptoResult!.logo)!,
                                                   placeholder: { Image("blackImage") },
                                                   image: { Image(uiImage: $0).resizable() })
                                            .frame(width: 80, height: 80, alignment: .center)
                                            .clipShape(Circle())
                                            .aspectRatio(contentMode: .fill)
                                            .shadow(radius: 8)
                                }
                                Text("\(orderCryptoResult!.name) (\(orderCryptoResult!.cryptoSymbol))")
                                    .font(.custom("Helvetica", fixedSize: 18))
                                    .foregroundColor(.white)
                                    .bold()
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                TripleRowView(label1: "Order Type", value1: orderCryptoResult!.orderType, label2: "Status", value2: orderCryptoResult!.orderStatus, label3: "Action", value3: orderCryptoResult!.orderAction)
                                DoubleRowView(label1: "Date Submitted", value1: orderCryptoResult!.dateSubmitted.toDateTimeFormatShort(), label2: "Date Filled", value2: orderCryptoResult!.dateFilled.toDateTimeFormatShort())
                                DoubleRowView(label1: "Qty Submitted", value1: "\(orderCryptoResult!.quantitySubmitted.formatPrice()) \(unitText)", label2: "Qty Filled", value2: "\(orderCryptoResult!.quantityFilled.formatPrice()) \(unitText)")
                                SingleRowView(label: "Commission", value: "$\(orderCryptoResult!.commission)")
                                DoubleRowView(label1: "", value1: "\(orderCryptoResult!.quantityFilled.formatPrice()) \(unitText) @ $\(orderCryptoResult!.pricePerShare.formatPrice()) per unit", label2: "Price Filled", value2: "$\(orderCryptoResult!.totalPriceFilled.formatPrice())")
                                if(orderCryptoResult!.orderAction.uppercased() == "BUY"){
                                    SingleRowView(label: "Total Cost", value: "$\(orderCryptoResult!.totalCost.formatPrice())")
                                }
                                else if(orderCryptoResult!.orderAction.uppercased() == "SELL"){
                                    SingleRowView(label: "Total Value", value: "$\((orderCryptoResult!.totalCost - orderCryptoResult!.commission).formatPrice())")
                                }
                              
                            }.lineLimit(1).minimumScaleFactor(0.5)
                        }
                        
                    }
                )
                   
        }
}

struct OrderSucessPageView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSucessPageView(isCrypto: false, orderStockResult: StockSymbolModel().orderResult, orderCryptoResult: nil).preferredColorScheme(.dark)
        OrderSucessPageView(isCrypto: true, orderStockResult: nil, orderCryptoResult: StockSymbolModel().orderResultCrypto).preferredColorScheme(.dark)
    }
}
