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
            HStack {
                Text("$\(myAppObjects.userWallet.total.formatPrice())")
                    .foregroundColor(.white)
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 48))
                    .bold()
                    +
                    Text(" \(userAuth.user.currency)")
                    .foregroundColor(.white)
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                    .bold()
                    .baselineOffset(0)
            }.padding(.horizontal, 20)
            .padding(.top, 20)
            
            VStack{
                ///Today's Return
                ZStack{
                    VStack(alignment: .center){
                        HStack{
                            RoundedRectangle(cornerRadius: 14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                ).foregroundColor(myColors.grayColor)
                            
                        }.frame(height: 28)
                        .padding(.horizontal)
                    }
                }
                .overlay(
                        VStack(spacing: 10) {
                                HStack {
                                    Text("Today's Return")
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                                    Spacer()
                                 
                                        Text("(\(myAppObjects.userWallet.percentReturnToday.formatPercentChange())%)")
                                            .foregroundColor(myAppObjects.userWallet.percentReturnToday >= 0 ? .green : .red)
                                            .font(.custom("Verdana", fixedSize: 16))
                                    
                                        Text("\(myAppObjects.userWallet.moneyReturnToday.formatPercentChange())")
                                            .foregroundColor(myAppObjects.userWallet.percentReturnToday >= 0 ? .green : .red)
                                            .font(.custom("Verdana", fixedSize: 16))
                                    
                                }.padding(.horizontal, 20)
                        }.padding(.horizontal, 4)
                    .lineLimit(1).minimumScaleFactor(0.5)
                    
                )
                ///All Time Return
                ZStack{
                    VStack(alignment: .center){
                        HStack{
                            RoundedRectangle(cornerRadius: 14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                ).foregroundColor(myColors.grayColor)
                            
                        }.frame(height: 28)
                        .padding(.horizontal)
                    }
                }
                .overlay(
                        VStack(spacing: 10) {
                                HStack {
                                    Text("All Time Return")
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                                    Spacer()
                                        Text("(\(myAppObjects.userWallet.percentReturnTotal.formatPercentChange())%)")
                                            .foregroundColor(myAppObjects.userWallet.percentReturnTotal >= 0 ? .green : .red)
                                            .font(.custom("Verdana", fixedSize: 16))

                                        Text("\(myAppObjects.userWallet.moneyReturnTotal.formatPercentChange())")
                                            .foregroundColor(myAppObjects.userWallet.percentReturnTotal >= 0 ? .green : .red)
                                            .font(.custom("Verdana", fixedSize: 16))
                                }.padding(.horizontal, 20)
                        }.padding(.horizontal, 4)
                    .lineLimit(1).minimumScaleFactor(0.5)
                    
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
