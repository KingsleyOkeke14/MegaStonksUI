//
//  PortfolioSummaryView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-10.
//

import SwiftUI

struct PortfolioSummaryView: View {
    @State var gainsOptionText:String = "All Time Gains"
    @State var isAllTimeGains:Bool = true
    
    let myColors = MyColors()
    var body: some View {
                VStack(spacing: 10) {
                    HStack{
                        Text("Portfolio")
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                            .fontWeight(.heavy)
                            .bold()
                            .foregroundColor(myColors.greenColor)
                            .padding(.horizontal)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Button(action: {
                            isAllTimeGains.toggle()
                            toggleGainsText(isAllTimeGains: isAllTimeGains)
                            
                            
                            
                        }, label: {
                            Text(gainsOptionText)
                                .font(.custom("Marker Felt", fixedSize: 14))
                                .bold()
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(myColors.lightGrayColor)
                                .foregroundColor(.white)
                                
                                
                                .cornerRadius(20)
                        }).padding(.horizontal)
                    }
                    SummarySectionView(gainsOptionText: $gainsOptionText)
                }
    }
    
    func toggleGainsText(isAllTimeGains:Bool){
        if(isAllTimeGains){
            gainsOptionText = "All Time Gains"
        }
        else{
            gainsOptionText = "Today's Gains"
        }
    }
}

struct PortfolioSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioSummaryView()
            .preferredColorScheme(.dark)
    }
}

struct SummarySectionView: View {
    let myColors = MyColors()
    @Binding var gainsOptionText:String
    
    
    var body: some View {
        HStack{
            VStack(alignment: .center){
                
                ZStack{
                    
                    
                    
                    
                    VStack(spacing: 24) {
                        HStack {
                            Text("Summary")
                                .font(.custom("Marker Felt", fixedSize: 20))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                            
                            Spacer()
                            Text(gainsOptionText)
                                .font(.custom("Marker Felt", fixedSize: 20))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.leading, 12)
                            
                        }.padding(.trailing, 20)
                        .padding(.top, 4)
                        
                        
                        HStack {
                            Text("$10,000,000.20")
                                .foregroundColor(.white)
                                .font(.custom("Verdana", fixedSize: 24))
                                .bold()
                                +
                                Text(" CAD")
                                .foregroundColor(.white)
                                .font(.custom("Verdana", fixedSize: 14))
                                .bold()
                                .baselineOffset(0)
                        }.padding(.horizontal, 20)
                        HStack {
                            Text("+(10.20%)")
                                .foregroundColor(.green)
                                .font(.custom("Verdana", fixedSize: 14))
                            Spacer()
                            Image("arrowUp")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 40)
                                .scaleEffect(0.4)
                                //.padding(.bottom, 20)
                            
                            
                            Spacer()
                            Text("+1,460,00000")
                                .foregroundColor(.green)
                                .font(.custom("Verdana", fixedSize: 14))
                            
                        }.padding(.horizontal, 20)
                        
                    }
                    
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.green, lineWidth: 4)
                        .shadow(color: Color.green, radius: 6, x: 4, y: 4)
                    )
                .padding()
                
            }
            
            
        }
    }
}
