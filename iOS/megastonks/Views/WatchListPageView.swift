//
//  WatchListPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-26.
//

import SwiftUI

struct WatchListPageView: View {
    
    let myColors = MyColors()
    @EnvironmentObject var userAuth:UserAuth
    @EnvironmentObject var myAppObjects:AppObjects
    
    @State var currentPage: Int = 0
    
    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
    
    
    
    var body: some View {
        NavigationView{
            VStack {
                Image("megastonkslogo")
                    .scaleEffect(0.6)
                    .aspectRatio(contentMode: .fit)
                HStack(spacing: 20){
                    VStack{
                        if(currentPage == 0){
                            Text("Stocks")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                .fontWeight(.heavy)
                                .bold()
                                .foregroundColor(.black)
                                .padding(.horizontal, 6)
                                .background(myColors.greenColor)
                                .cornerRadius(6)
                                .onTapGesture(perform: {
                                    impactMed.impactOccurred()
                                })
                        }
                        else {
                            Text("Stocks")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                .fontWeight(.heavy)
                                .bold()
                                .foregroundColor(myColors.greenColor)
                                .onTapGesture(perform: {
                                    impactMed.impactOccurred()
                                    self.currentPage = 0
                                })
                        }
                    }
                    
                    VStack{
                        if(currentPage == 1){
                            Text("Crypto")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                .fontWeight(.heavy)
                                .bold()
                                .foregroundColor(.black)
                                .padding(.horizontal, 6)
                                .background(myColors.greenColor)
                                .cornerRadius(6)
                                .onTapGesture(perform: {
                                    impactMed.impactOccurred()
                                })
                        }
                        else{
                            Text("Crypto")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                .fontWeight(.heavy)
                                .bold()
                                .foregroundColor(myColors.greenColor)
                                .padding(.horizontal, 6)
                                .onTapGesture(perform: {
                                    impactMed.impactOccurred()
                                    self.currentPage = 1
                                })
                            
                        }
                    }
                }
                
                
                TabView(selection: $currentPage) {
                    AssetWatchListPage(isCrypto: false).tag(0)
                    AssetWatchListPage(isCrypto: true).tag(1)
                        }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: PageTabViewStyle.IndexDisplayMode.never))
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct WatchListPageView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListPageView()
            .environmentObject(UserAuth())
            .environmentObject(AppObjects())
            .preferredColorScheme(.dark)
    }
}
