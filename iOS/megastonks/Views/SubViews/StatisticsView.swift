//
//  StatisticsView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-09.
//

import SwiftUI

struct StatisticsView: View {
    let myColors = MyColors()
    var body: some View {
//                Color.black
//                    .ignoresSafeArea()
//                    .overlay(
        
        VStack {
            
            
            
            VStack(alignment: .leading, spacing: 2){
                Text("Statistics")
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                    .bold()
                    .foregroundColor(myColors.greenColor)
                    .padding(.top)
                
                Rectangle()
                    .fill(myColors.lightGrayColor)
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)
                
            }
            PriceActionView(label: "52 Week Price Action", lowPrice: "$2.34", highPrice: "$4.22")
            PriceActionView(label: "Today's Price Action", lowPrice: "$3.44", highPrice: "$6.44")
            
            VStack{
                SingleStatView(label: "Today's Opening Price", value: "$5.02")
                SingleStatView(label: "Market Cap", value: "46.06B")
                SingleStatView(label: "Average Volume", value: "13.34M")
                SingleStatView(label: "Volume", value: "26.30M")
                
                SingleStatView(label: "Exchange", value: "CNQ")
            }
            //                    )
        }.padding(.horizontal)
//        )
    }
}

struct PriceActionView: View {
    let myColors = MyColors()
    
    var label:String
    var lowPrice:String
    var highPrice:String
    var body: some View {
        VStack{
            HStack{
                Text("Low")
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", fixedSize: 12))
                Spacer()
                Text(label)
                    .font(.custom("Verdana", fixedSize: 14))
                    .bold()
                    .foregroundColor(myColors.lightGrayColor)
                Spacer()
                Text("High")
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", fixedSize: 12))
            }
            HStack{
                Text(lowPrice)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", fixedSize: 20))
                Spacer()
                Image(systemName: "chart.bar.fill")
                    .foregroundColor(myColors.lightGreenColor)
                   
                Spacer()
                Text(highPrice)
                    .foregroundColor(.white)
                    .bold()
                    .font(.custom("Verdana", fixedSize: 20))
            }
            Rectangle()
                .fill(myColors.lightGrayColor)
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
}

struct SingleStatView: View {
    var label:String
    var value:String
    let myColors = MyColors()
    var body: some View {
        VStack{
            Text(label)
                .font(.custom("Verdana", fixedSize: 14))
                .bold()
                .foregroundColor(myColors.lightGrayColor)
            Text(value)
                .foregroundColor(.white)
                .bold()
                .font(.custom("Verdana", fixedSize: 20))
            Rectangle()
                .fill(myColors.lightGrayColor)
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}



