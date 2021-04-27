//
//  MyHoldingsView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-09.
//

import SwiftUI

struct MyHoldingsView: View {
    
    @Binding var themeColor:Color
    
    let myColors = MyColors()
    var body: some View {
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
                    DoubleColumnedView(themeColor: $themeColor, column1Field: "My Shares", column1Text: "188", column2Field: "Market Value", column2Text: "$464.36", isPortfolio: false)
                    DoubleColumnedView(themeColor: $themeColor, column1Field: "Average Cost", column1Text: "$1.83", column2Field: "% of My Portfolio", column2Text: "10.00%", isPortfolio: true)
                    SingleColumnView(columnField: "Today's Return", textField: "+$2.88 (+10.12%)")
                    SingleColumnView(columnField: "Total Return", textField: "$200.88 (+25.46%)")
                }.padding(.horizontal)
        
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
                                        .trim(from: 0.0, to: 0.4)
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
        MyHoldingsView(themeColor: Binding.constant(Color.red))
            .preferredColorScheme(.dark)
    }
}
