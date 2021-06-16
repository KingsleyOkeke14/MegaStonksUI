//
//  OrderDetailView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-13.
//

import SwiftUI

struct OrderDetailView: View {
    
    var orderHistoryElement: OrderHistoryElement
    var shareText = "Shares"
    
    init(orderHistoryElement: OrderHistoryElement){
        self.orderHistoryElement = orderHistoryElement
        self.shareText = orderHistoryElement.quantityFilled <= 1.0 ? "Share" : "Shares"
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
                            Text(orderHistoryElement.orderStatus)
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
                                Text(orderHistoryElement.symbol)
                                    .font(.custom("Verdana", fixedSize: 20))
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: 80, height: 80, alignment: .center)
                                    .padding()
                            }
                            
                        }
                        
                        
                        Text(orderHistoryElement.name)
                            .font(.custom("Helvetica", fixedSize: 16))
                            .foregroundColor(.white)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        TripleRowView(label1: "Order Type", value1: orderHistoryElement.orderType, label2: "Status", value2: orderHistoryElement.orderStatus, label3: "Action", value3: orderHistoryElement.orderAction)
                        DoubleRowView(label1: "Date Submitted", value1: orderHistoryElement.dateSubmitted.toDateTimeFormat(), label2: "Date Filled", value2: orderHistoryElement.dateFilled.toDateTimeFormat())
                        DoubleRowView(label1: "Qty Submitted", value1: "\(orderHistoryElement.quantitySubmitted.formatNoDecimal()) \(shareText)", label2: "Qty Filled", value2: "\(orderHistoryElement.quantityFilled.formatNoDecimal()) \(shareText)")
                        SingleRowView(label: "Commission", value: "$\(orderHistoryElement.commission)")
                        DoubleRowView(label1: "", value1: "\(orderHistoryElement.quantityFilled.formatNoDecimal()) \(shareText) x $\(orderHistoryElement.pricePerShare)", label2: "Price Filled", value2: "$\(orderHistoryElement.totalPriceFilled)")
                        if(orderHistoryElement.orderAction.uppercased() == "BUY"){
                            SingleRowView(label: "Total Cost", value: "$\(orderHistoryElement.totalCost)")
                        }
                        else if(orderHistoryElement.orderAction.uppercased() == "SELL"){
                            SingleRowView(label: "Total Value", value: "$\((orderHistoryElement.totalPriceFilled - orderHistoryElement.commission).formatPrice())")
                        }
                        
                    }.lineLimit(1).minimumScaleFactor(0.5)
                }
            )
    }
}


struct SingleRowView: View {
    var label:String
    var value:String
    
    let myColors = MyColors()
    var body: some View {
        VStack{
            HStack {
                Text(label)
                    .foregroundColor(myColors.lightGrayColor)
                    
                    .font(.custom("Verdana", fixedSize: 16))
                Spacer()
                Text(value)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", fixedSize: 16))
            }
            
            Rectangle()
                .fill(myColors.lightGrayColor)
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
        }.padding(.horizontal)
    }
}

struct DoubleRowView: View {
    var label1:String
    var value1:String
    var label2:String
    var value2:String
    
    let myColors = MyColors()
    var body: some View {
        VStack{
            HStack {
                Text(label1)
                    .foregroundColor(myColors.lightGrayColor)
                    .font(.custom("Verdana", fixedSize: 16))
                Spacer()
                Text(value1)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", fixedSize: 16))
            }
            HStack {
                Text(label2)
                    .foregroundColor(myColors.lightGrayColor)
                    .font(.custom("Verdana", fixedSize: 16))
                Spacer()
                Text(value2)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", fixedSize: 16))
            }
            
            Rectangle()
                .fill(myColors.lightGrayColor)
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
        }.padding(.horizontal)
    }
}

struct TripleRowView: View {
    var label1:String
    var value1:String
    var label2:String
    var value2:String
    var label3:String
    var value3:String
    
    let myColors = MyColors()
    var body: some View {
        VStack{
            HStack {
                Text(label1)
                    .foregroundColor(myColors.lightGrayColor)
                    .font(.custom("Verdana", fixedSize: 16))
                Spacer()
                Text(value1)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", fixedSize: 16))
            }
            HStack {
                Text(label2)
                    .foregroundColor(myColors.lightGrayColor)
                    .font(.custom("Verdana", fixedSize: 16))
                Spacer()
                Text(value2)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", fixedSize: 16))
            }
            HStack {
                Text(label3)
                    .foregroundColor(myColors.lightGrayColor)
                    .font(.custom("Verdana", fixedSize: 16))
                Spacer()
                Text(value3)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", fixedSize: 16))
            }
            
            Rectangle()
                .fill(myColors.lightGrayColor)
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
        }.padding(.horizontal)
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(orderHistoryElement: StockSymbolModel().orderHistoryElement)
    }
}
