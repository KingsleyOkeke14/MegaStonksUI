//
//  PortfolioSummaryView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-10.
//

import SwiftUI

struct PortfolioSummaryView: View {
    @Binding var isAllTimeGains:Bool
    
    @EnvironmentObject var myAppObjects:AppObjects
    @EnvironmentObject var userAuth: UserAuth
    
    
    let myColors = MyColors()
    var body: some View {
        VStack(spacing: 16) {
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
                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                    impactMed.impactOccurred()
                    isAllTimeGains.toggle()
                    
                }, label: {
                    Text(isAllTimeGains ? "All Time Gains" : "Today's Gains")
                        .font(.custom("Marker Felt", fixedSize: 14))
                        .bold()
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(myColors.lightGrayColor)
                        .foregroundColor(.white)
                        
                        
                        .cornerRadius(20)
                }).padding(.horizontal)
            }
            HStack{
                VStack(alignment: .center){
                    
                    ZStack{
                        VStack(spacing: 20) {
                            HStack {
                                Text("Summary")
                                    .font(.custom("Marker Felt", fixedSize: 20))
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                Text(isAllTimeGains ? "All Time Gains" : "Today's Gains")
                                    .font(.custom("Marker Felt", fixedSize: 20))
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(.leading, 12)
                                
                            }.padding(.trailing, 20)
                            .padding(.top, 4)
                            
                            
                            HStack {
                                Text("$\(myAppObjects.userWallet.total.formatPrice())")
                                    .foregroundColor(.white)
                                    .font(.custom("Verdana", fixedSize: 24))
                                    .bold()
                                    +
                                    Text(" \(userAuth.user.currency)")
                                    .foregroundColor(.white)
                                    .font(.custom("Verdana", fixedSize: 14))
                                    .bold()
                                    .baselineOffset(0)
                            }.padding(.horizontal, 20)
                            GeometryReader{ geometry in
                                HStack {
                                    Spacer()
                                    if(isAllTimeGains){
                                        Text("(\(myAppObjects.userWallet.percentReturnTotal.formatPercentChange())%)")
                                            .foregroundColor(myAppObjects.userWallet.percentReturnTotal >= 0 ? .green : .red)
                                            .font(.custom("Verdana", fixedSize: 16))
                                            .frame(width: geometry.size.width * 0.3, alignment: .trailing)
                                    }
                                    else{
                                        Text("(\(myAppObjects.userWallet.percentReturnToday.formatPercentChange())%)")
                                            .foregroundColor(myAppObjects.userWallet.percentReturnToday >= 0 ? .green : .red)
                                            .font(.custom("Verdana", fixedSize: 16))
                                            .frame(width: geometry.size.width * 0.3, alignment: .trailing)
                                    }
                                    
                                    
                                    Spacer()
                                    if(isAllTimeGains){
                                        Image(systemName: myAppObjects.userWallet.percentReturnTotal >= 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                                            .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                            .foregroundColor(myAppObjects.userWallet.percentReturnTotal >= 0 ? .green : .red)
                                            .scaleEffect(1.4)
                                            .frame(width: geometry.size.width * 0.2, alignment: .center)
                                    }
                                    else{
                                        Image(systemName: myAppObjects.userWallet.percentReturnToday >= 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                                            .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                            .foregroundColor(myAppObjects.userWallet.percentReturnToday >= 0 ? .green : .red)
                                            .scaleEffect(1.4)
                                            .frame(width: geometry.size.width * 0.2, alignment: .center)
                                    }
                                    
                                    
                                    
                                    Spacer()
                                    if(isAllTimeGains){
                                        Text("\(myAppObjects.userWallet.moneyReturnTotal.formatPercentChange())")
                                            .foregroundColor(myAppObjects.userWallet.percentReturnTotal >= 0 ? .green : .red)
                                            .font(.custom("Verdana", fixedSize: 16))
                                            .frame(width: geometry.size.width * 0.3, alignment: .leading)
                                    }
                                    else{
                                        Text("\(myAppObjects.userWallet.moneyReturnToday.formatPercentChange())")
                                            .foregroundColor(myAppObjects.userWallet.percentReturnToday >= 0 ? .green : .red)
                                            .font(.custom("Verdana", fixedSize: 16))
                                            .frame(width: geometry.size.width * 0.3, alignment: .leading)
                                    }
                                    
                                    Spacer()
                                }.padding(.horizontal, 20)
                            }.frame(height: 28, alignment: .center)
                            
                        }
                        
                        
                    }.lineLimit(1).minimumScaleFactor(0.5)
                    
                }
                .overlay(
                    HStack{
                        if(isAllTimeGains){
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(myAppObjects.userWallet.percentReturnTotal >= 0 ? Color.green : Color.red, lineWidth: 4)
                                .shadow(color: myAppObjects.userWallet.percentReturnTotal >= 0 ? .green : .red, radius: 6, x: 4, y: 4)
                            
                        }
                        else{
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(myAppObjects.userWallet.percentReturnToday >= 0 ? Color.green : Color.red, lineWidth: 4)
                                .shadow(color: myAppObjects.userWallet.percentReturnToday >= 0 ? .green : .red, radius: 6, x: 4, y: 4)
                            
                        }
                        
                    }.padding(.horizontal)
                )
                
                
            }
            
            
        }
    }
}

struct PortfolioSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioSummaryView(isAllTimeGains: Binding.constant(false))
            .environmentObject(AppObjects())
            .environmentObject(UserAuth())
            .preferredColorScheme(.dark)
        
    }
}
