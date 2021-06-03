//
//  CompanyInfoView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-10.
//

import SwiftUI

struct CompanyInfoView: View {
    let myColors = MyColors()
    @Binding var stockSymbol: StockSymbol
    @Binding var themeColor: Color
    
    var body: some View {
        if(!stockSymbol.description.isEmpty){
            VStack(alignment: .leading, spacing: 2){
                Text("Company Information")
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                    .bold()
                    .foregroundColor(themeColor)
                    .padding(.top)
                
                Rectangle()
                    .fill(myColors.lightGrayColor)
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)
                Text(stockSymbol.description)
                    .foregroundColor(.white)
                    .font(.custom("Verdana", fixedSize: 14))
                
            }.padding()
        }
    }
}


struct TokenInfoView: View {
    let myColors = MyColors()
    @Binding var cryptoSymbol: CryptoSymbol?
    @Binding var themeColor: Color
    @Environment(\.openURL) var openURL
    
    var body: some View {
        if(!cryptoSymbol!.info.infoDescription.isEmpty){
            VStack(alignment: .leading, spacing: 2){
                Text("Token Information")
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                    .bold()
                    .foregroundColor(themeColor)
                    .padding(.top)
                
                Rectangle()
                    .fill(myColors.lightGrayColor)
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)
                Text(cryptoSymbol!.info.infoDescription)
                    .foregroundColor(.white)
                    .font(.custom("Verdana", fixedSize: 14))
                
                
                VStack {
                    Text("Social Accounts")
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                        .bold()
                        .foregroundColor(themeColor)
                        .padding(.top)
                        .opacity(0.8)
                    HStack{
                        Spacer()
                        if(!cryptoSymbol!.info.website.isEmpty){
                            VStack {
                                Button(action: {
                                    openURL(URL(string: cryptoSymbol!.info.website)!)
                                }, label: {
                                    Image(systemName: "globe")
                                        .resizable()
                                        .frame(width: 40, height: 36)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .opacity(0.8)
                            })
                                Text("Website")
                                    .foregroundColor(.white)
                                    .font(.custom("Verdana", fixedSize: 14))
                                
                            }
                        }
                        if(!cryptoSymbol!.info.twitter.isEmpty){
                            VStack {
                                Button(action: {
                                    openURL(URL(string: cryptoSymbol!.info.twitter)!)
                                }, label: {
                                    Image("twitterLogo")
                                        .resizable()
                                        .frame(width: 40, height: 36)
                                        .padding(.horizontal)
                                  
                            })
                                Text("Twitter")
                                    .foregroundColor(.white)
                                    .font(.custom("Verdana", fixedSize: 14))
                            }
                        }
                        if(!cryptoSymbol!.info.reddit.isEmpty){
                            VStack {
                                Button(action: {
                                    openURL(URL(string: cryptoSymbol!.info.reddit)!)
                                }, label: {
                                    Image("redditLogo")
                                        .resizable()
                                        .frame(width: 40, height: 36)
                                        .padding(.horizontal)
                                  
                            })
                                Text("Reddit")
                                    .foregroundColor(.white)
                                    .font(.custom("Verdana", fixedSize: 14))
                            }
                        }
                        Spacer()
                    }
                }
                
            }.padding()
        }
    }
}

struct CompanyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        
        TokenInfoView(cryptoSymbol: Binding.constant(StockSymbolModel().cryptoSymbol), themeColor: Binding.constant(Color.red))
            .preferredColorScheme(.dark)
        CompanyInfoView(stockSymbol: Binding.constant(StockSymbolModel().symbols[1]), themeColor: Binding.constant(Color.red))
            .preferredColorScheme(.dark)
        
        
    }
}
