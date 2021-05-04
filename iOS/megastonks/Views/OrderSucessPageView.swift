//
//  OrderSucessPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-03.
//

import SwiftUI

struct OrderSucessPageView: View {
        
        var orderResult: OrderResultInfo
        var shareText = "Shares"
        
        init(orderResult: OrderResultInfo){
            self.orderResult = orderResult
            self.shareText = orderResult.quantityFilled <= 1.0 ? "Share" : "Shares"
        }
        
        let myColors = MyColors()
        var body: some View {
            Color.black
                .ignoresSafeArea()
                .overlay(
                    ScrollView{
                        Spacer(minLength: 20)
                        VStack(spacing: 20){
                            
                            HStack{
                                Text(orderResult.orderStatus)
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
                                    Text(orderResult.stockSymbol)
                                        .font(.custom("Verdana", fixedSize: 20))
                                        .bold()
                                        .foregroundColor(.white)
                                        .frame(width: 80, height: 80, alignment: .center)
                                        .padding()
                                }

                            }

                            
                            Text(orderResult.name)
                                .font(.custom("Verdana", fixedSize: 16))
                                .foregroundColor(.white)
                                .bold()
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            TripleRowView(label1: "Order Type", value1: orderResult.orderType, label2: "Status", value2: orderResult.orderStatus, label3: "Action", value3: orderResult.orderAction)
                            DoubleRowView(label1: "Date Submitted", value1: orderResult.dateSubmitted, label2: "Date Filled", value2: orderResult.dateFilled)
                            DoubleRowView(label1: "Qty Submitted", value1: "\(orderResult.quantitySubmitted.formatNoDecimal()) \(shareText)", label2: "Qty Filled", value2: "\(orderResult.quantityFilled.formatNoDecimal()) \(shareText)")
                            SingleRowView(label: "Commission", value: "$\(orderResult.commission)")
                            TripleRowView(label1: "Currency", value1: "\(orderResult.currency)", label2: "Forex Exchange", value2: "\(orderResult.forexExchangeRate.formatForex())", label3: "Amount Exchanged", value3: "\(orderResult.exchangeResult.formatForex())")
                            DoubleRowView(label1: "", value1: "\(orderResult.quantityFilled.formatNoDecimal()) \(shareText) x $\(orderResult.pricePerShare.formatPrice())", label2: "Price Filled", value2: "$\(orderResult.totalPriceFilled.formatPrice())")
                            if(orderResult.orderAction.uppercased() == "BUY"){
                                SingleRowView(label: "Total Cost", value: "$\(orderResult.totalCost.formatPrice())")
                            }
                            else if(orderResult.orderAction.uppercased() == "SELL"){
                                SingleRowView(label: "Total Value", value: "$\((orderResult.totalCost - orderResult.commission).formatPrice())")
                            }
                          
                        }.lineLimit(1).minimumScaleFactor(0.5)
                    }
                  
            )
        }
}

struct OrderSucessPageView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSucessPageView(orderResult: StockSymbolModel().orderResult)
    }
}
