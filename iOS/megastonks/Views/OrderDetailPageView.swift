//
//  OrderDetailView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-13.
//

import SwiftUI

struct OrderDetailView: View {
    let myColors = MyColors()
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack(spacing: 20){
                    HStack{
                        Text("Executed")
                            .foregroundColor(myColors.greenColor)
                            .font(.custom("Verdana", size: 24))
                            .bold()

                    }

                    HStack{
                        ZStack{
                            Circle()
                                .stroke(myColors.greenColor, lineWidth: 4)
                                .frame(width: 110, height: 110)
                                .shadow(color: myColors.greenColor, radius: 6, x: 4, y: 4)
                            Circle()
                                .fill(myColors.grayColor)
                                .frame(width: 110, height: 110)
                            Text("DOC")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding()
                        }

                    }

                    
                    Text("CloudMD Software & Services Inc")
                        .font(.custom("Helvetica", size: 20))
                        .foregroundColor(.white)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    DoubleRowView(label1: "Order Type", value1: "Market", label2: "Status", value2: "Executed")
                    DoubleRowView(label1: "Date Submitted", value1: "Feb 8, 2020 11:40AM", label2: "Date Filled", value2: "Feb 8, 2020 11:40AM")
                    DoubleRowView(label1: "Qty Submitted", value1: "32 Shares", label2: "Qty Filled", value2: "32 Shares")
                    SingleRowView(label: "Commission", value: "$4.00")
                    TripleRowView(label1: "", value1: "200 Shares x $1.20", label2: "Price Filled", value2: "$240", label3: "Comission", value3: "$4")
                    SingleRowView(label: "Total", value: "$244.00")
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
                  
                    .font(.custom("Verdana", size: 18))
                Spacer()
                Text(value)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", size: 18))
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
                    .font(.custom("Verdana", size: 18))
                Spacer()
                Text(value1)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", size: 18))
            }
            HStack {
                Text(label2)
                    .foregroundColor(myColors.lightGrayColor)
                    .font(.custom("Verdana", size: 18))
                Spacer()
                Text(value2)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", size: 18))
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
                    .font(.custom("Verdana", size: 18))
                Spacer()
                Text(value1)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", size: 18))
            }
            HStack {
                Text(label2)
                    .foregroundColor(myColors.lightGrayColor)
                    .font(.custom("Verdana", size: 18))
                Spacer()
                Text(value2)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", size: 18))
            }
            HStack {
                Text(label3)
                    .foregroundColor(myColors.lightGrayColor)
                    .font(.custom("Verdana", size: 18))
                Spacer()
                Text(value3)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", size: 18))
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
        OrderDetailView()
    }
}
