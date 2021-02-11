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
                            .font(.custom("Apple SD Gothic Neo", size: 22))
                            .fontWeight(.heavy)
                            .bold()
                            .foregroundColor(.white)
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
                                .font(.custom("Marker Felt", size: 14))
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
                    
                    
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.green, lineWidth: 4)
                        .frame(width: 380, height: 180)
                        .shadow(color: Color.green, radius: 6, x: 4, y: 4)
                    RoundedRectangle(cornerRadius: 14)
                        .fill(myColors.grayColor)
                        .frame(width: 380, height: 180)
                    
                    VStack(spacing: 34) {
                        HStack {
                            Text("Summary")
                                .font(.custom("Marker Felt", size: 20))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                            
                            Spacer()
                            Text(gainsOptionText)
                                .font(.custom("Marker Felt", size: 20))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.leading, 12)
                            
                        }.padding(.trailing, 20)
                        
                        HStack {
                            Text("$10,000,000.20")
                                .foregroundColor(.white)
                                .font(.custom("Verdana", size: 34))
                                .bold()
                                +
                                Text(" CAD")
                                .foregroundColor(.white)
                                .font(.custom("Verdana", size: 18))
                                .bold()
                                .baselineOffset(0)
                        }.padding(.horizontal, 20)
                        HStack {
                            Text("+(10.20%)")
                                .foregroundColor(.green)
                                .font(.custom("Verdana", size: 18))
                            Spacer()
                            Image("arrowUp")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 60)
                                .scaleEffect(0.6)
                                .padding(.bottom)
                            
                            
                            Spacer()
                            Text("+1,460,0000")
                                .foregroundColor(.green)
                                .font(.custom("Verdana", size: 18))
                            
                        }.padding(.horizontal, 20).padding(.vertical, -20)
                        
                    }
                    
                }
                
            }
            
            
        }
    }
}
