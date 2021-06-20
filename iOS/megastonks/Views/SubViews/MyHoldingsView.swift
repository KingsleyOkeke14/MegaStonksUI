//
//  MyHoldingsView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-09.
//

import SwiftUI

struct MyHoldingsView: View {
    
    var isCrypto: Bool
    @Binding var themeColor:Color
    
    @Binding var holding:HoldingInfoPage
    
    @State var showTip:Bool = false
    
    let myColors = MyColors()
    var body: some View {
        if(holding.quantity! > 0){
            VStack{
                VStack(alignment: .leading, spacing: 2){
                    Text("My Holdings")
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                        .bold()
                        .foregroundColor(themeColor)
                        .padding(.top)
                    
                    Rectangle()
                        .fill(myColors.lightGrayColor)
                        .frame(height: 2)
                        .edgesIgnoringSafeArea(.horizontal)
                    
                }
                DoubleColumnedView(themeColor: $themeColor, column1Field: isCrypto ? "Units" : "My Shares", column1Text: isCrypto ? "\(holding.quantity!.formatPrice())" : "\(holding.quantity!.formatNoDecimal())", column2Field: "Market Value", column2Text: "$\(holding.marketValue!.formatPrice())", isPortfolio: false, percentofPortfolio: 0)
                DoubleColumnedView(themeColor: $themeColor, column1Field: "Average Cost", column1Text: "$\(holding.averageCost!.formatPrice())", column2Field: "% of My Portfolio", column2Text: "\(holding.percentOfPortfolio!.formatPrice())%", isPortfolio: true, percentofPortfolio: CGFloat(holding.percentOfPortfolio!/100))
                
                VStack{
                    HStack{
                        if(!showTip){
                            Text("Today's Return")
                                .font(.custom("Verdana", fixedSize: 14))
                                .bold()
                                .foregroundColor(myColors.lightGrayColor)
                        }
                        Button(action: {
                            showTip.toggle()
                        }, label: {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.white)
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                        })
                        
                        if(showTip){
                            Text("Calculation assumes an overnight holding of the asset")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                .foregroundColor(.white)
                                .lineLimit(4)
                                .multilineTextAlignment(.center)
                        }
                    }
                    Text("\(holding.moneyReturnToday!.signToString())$\(fabs(holding.moneyReturnToday!).formatPrice()) (\(holding.percentReturnToday!.formatPercentChange())%)")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 20))
                    Rectangle()
                        .fill(myColors.lightGrayColor)
                        .frame(height: 2)
                        .edgesIgnoringSafeArea(.horizontal)
                }
                SingleColumnView(columnField: "Total Return", textField: "\(holding.moneyReturnTotal!.signToString())$\(fabs(holding.moneyReturnTotal!).formatPrice()) (\(holding.percentReturnTotal!.formatPercentChange())%)")
            }
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding(.horizontal)
        }
        
    }
}

struct DoubleColumnedView: View {
    
    @Binding var themeColor:Color
    
    let myColors = MyColors()
    var column1Field:String
    var column1Text:String
    var column2Field:String
    var column2Text:String
    var isPortfolio:Bool
    var percentofPortfolio:CGFloat
    var body: some View {
        VStack{
            
            HStack{
                VStack(alignment: .center){
                    Text(column1Field)
                        .font(.custom("Verdana", fixedSize: 14))
                        .bold()
                        .foregroundColor(myColors.lightGrayColor)
                    Text(column1Text)
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 20))
                    
                    
                }
                Spacer()
                VStack(alignment: .center){
                    
                    if(isPortfolio){
                        VStack(spacing:2){
                            Text(column2Field)
                                .font(.custom("Verdana", fixedSize: 14))
                                .bold()
                                .foregroundColor(myColors.lightGrayColor)
                            HStack{
                                
                                ZStack{
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .opacity(0.3)
                                        .foregroundColor(themeColor)
                                    
                                    Circle()
                                        .trim(from: 0.0, to: percentofPortfolio)
                                        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: CGLineCap.round, lineJoin: .round))
                                        .foregroundColor(themeColor)
                                        .rotationEffect(Angle(degrees: 270))
                                        .animation(.linear)
                                }.frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                //RadialChartView(percentage: 0.4, width: 20, height: 20, lineWidth: 2, lineCapStyle: CGLineCap.round).offset(x: 0, y: 2)
                                Text(column2Text)
                                    .foregroundColor(.white)
                                    .font(.custom("Verdana", fixedSize: 20))
                            }
                        }
                    }
                    else{
                        Text(column2Field)
                            .font(.custom("Verdana", fixedSize: 14))
                            .bold()
                            .foregroundColor(myColors.lightGrayColor)
                        Text(column2Text)
                            .foregroundColor(.white)
                            .font(.custom("Verdana", fixedSize: 20))
                    }
                    
                    
                }
                
            }
            Rectangle()
                .fill(myColors.lightGrayColor)
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
}
struct SingleColumnView: View {
    let myColors = MyColors()
    var columnField:String
    var textField:String
    var body: some View {
        HStack{
            VStack{
                Text(columnField)
                    .font(.custom("Verdana", fixedSize: 14))
                    .bold()
                    .foregroundColor(myColors.lightGrayColor)
                Text(textField)
                    .foregroundColor(.white)
                    .font(.custom("Verdana", fixedSize: 20))
                Rectangle()
                    .fill(myColors.lightGrayColor)
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)
            }
            
        }
    }
    
    
    
}

struct MyHoldingsView_Previews: PreviewProvider {
    static var previews: some View {
        MyHoldingsView(isCrypto: false, themeColor: Binding.constant(Color.red), holding: Binding.constant(HoldingInfoPage(HoldingResponseInfoPage(id: 0, averageCost: 10000, quantity: 200.00, marketValue: 0, percentReturnToday: 0, moneyReturnToday: 0, percentReturnTotal: 0, moneyReturnTotal: 0, percentOfPortfolio: 0, lastUpdated: ""))))
            .preferredColorScheme(.dark)
    }
}
