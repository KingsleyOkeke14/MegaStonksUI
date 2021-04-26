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
                               foregroundColor: [ColorGradient(Color.init(red: 72/255, green: 175/255, blue: 56/255), Color.init(red: 72/255, green: 175/255, blue: 56/255))])
    
    @State var data1D = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 38.0)]
    
    @State var data5D = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 38.0)]
    
    @State var data1M = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 38.0)]
    
    @State var data3M = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 38.0)]
    
    @State var data1Y = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 38.0)]
    
    @State var data5Y = [("AMonday 1st 2020", 2.0), ("BMonday 1st 2020", 4.0), ("CMonday 1st 2020", 6.0), ("DMonday 1st 2020", 8.0), ("Monday 1st 2020", 10.0), ("Monday 1st 2020", 12.0), ("EMonday 1st 2020", 8.0), ("FMonday 1st 2020", 6.0), ("GMonday 1st 2020", 4.0), ("HMonday 1st 2020", 2.0), ("IMonday 1st 2020", 6.0), ("J", 4.0), ("K", 8.0), ("LMonday 1st 2020", 12.0), ("MMonday 1st 2020", 14.0), ("NMonday 1st 2020", 20.0), ("OMonday 1st 2020", 22.0), ("PMonday 1st 2020", 21.0), ("QMonday 1st 2020", 20.0), ("RMonday 1st 2020", 24.0), ("SMonday 1st 2020", 24.8), ("TMonday 1st 2020", 26.0), ("UMonday 1st 2020", 24.0), ("VMonday 1st 2020", 26.0), ("WMonday 1st 2020", 28.0), ("XMonday 1st 2020", 29.0), ("YMonday 1st 2020", 30.0), ("ZMonday 1st 2020", 34.0), ("ABMonday 1st 2020", 32.0), ("CDMonday 1st 2020", 38.0)]
    
    @State var stock:StockSymbol
    
    
    @State var chartButtonList:[(buttonName:String, buttonState:Bool)] = [(buttonName:String, buttonState:Bool)]()
    
    var body: some View {
        
        HStack {
            VStack(spacing: 0){
                HStack{
                    
                        
                    if(stock.change > 0){
                        Text(String(stock.change.formatPrice() + "  (" + stock.changesPercentage.formatPercentChange() + "%)"))
                            .font(.custom("Verdana", fixedSize: 16))
                            .bold()
                            .foregroundColor(.green)
                        
                    }
                    else if(stock.change < 0){
                        Text(String(stock.change.formatPrice() + "  (" + stock.changesPercentage.formatPercentChange() + "%)"))
                            .font(.custom("Verdana", fixedSize: 16))
                            .bold()
                            .foregroundColor(.red)
                    }
                    else if(stock.change == 0){
                        Text(String(stock.change.formatPrice() + "  (" + stock.changesPercentage.formatPercentChange() + "%)"))
                            .font(.custom("Verdana", fixedSize: 16))
                            .bold()
                            .foregroundColor(.gray)
                    }

                    Text("Today")
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
                        
                        
                        
                }
                .data(data1D)
                .chartStyle(greenStyle)
                ChartButtonView(buttonList: chartButtonList)
            }.background(Color.black)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let buttonTexts = [("1D", true), ("5D", false), ("1M", false), ("3M", false), ("1Y", false), ("5Y", false)]
        ChartView(stock: StockSymbolModel().symbols[0], chartButtonList: buttonTexts )
    }
}
