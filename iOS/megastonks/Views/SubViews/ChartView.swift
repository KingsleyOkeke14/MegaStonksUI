//
//  ChartView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-04.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    
    let myColors = MyColors()
    let greenStyle = ChartStyle(backgroundColor: .green,
                               foregroundColor: [ColorGradient(Color.green, Color.green)])
    
    let redStyle = ChartStyle(backgroundColor: .red,
                              foregroundColor: [ColorGradient(Color.red, Color.red)])
    
    @Binding var isStockGaining:Bool
    
    @Binding var themeColor: Color
    
    @Binding var data:[(String, Double)]
    
    @Binding var chartDiscrepancy:String
    
    @Binding var chartLabel:String
    
    
    @State var stock:StockSymbol
    
    
    var body: some View {
        
        HStack {
            VStack(spacing: 0){
                HStack{
                    Text(chartDiscrepancy)
                            .font(.custom("Verdana", fixedSize: 16))
                            .bold()
                            .foregroundColor(themeColor)
                    
                    Text(chartLabel)
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 12))
                        .bold()
                }
                        
                CardView(showShadow: true) {
                    ChartLabel("")
                        .background(Color.black)
                        .foregroundColor(.white)
                     
                    LineChart()
                        .background(Color.black)
                        .overlay(
                                VStack{
                                    if(data.count <= 0){
                                        Color.black
                                            .overlay(
                                                VStack{
                                                    Text("Data for the selected time period is not currently available")
                                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                                        .bold()
                                                        .foregroundColor(.gray)
                                                        .padding(.horizontal)
                                                        .multilineTextAlignment(.center)
                                                }
                                            )

                                    }
                                }
                        )
                }
                .data(data)
                .chartStyle(isStockGaining ? greenStyle : redStyle)
            
            }.background(Color.black)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(isStockGaining: Binding.constant(false), themeColor: Binding.constant(MyColors().redColor), data: Binding.constant([(String, Double)]()), chartDiscrepancy: Binding.constant(""), chartLabel: Binding.constant(""), stock: StockSymbolModel().symbols[1])
    }
}
