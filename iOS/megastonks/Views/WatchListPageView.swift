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
    
    @State var showBanner:Bool = false
    
    var stockBannerInfo:BannerData = BannerData(title: "", detail: "Swipe right on page to view stocks watchlist", type: .Info)
    
    var cryptoBannerInfo:BannerData = BannerData(title: "", detail: "Swipe left on page to view crypto watchlist", type: .Info)
    
    @State var bannerData:BannerData = BannerData(title: "", detail: "", type: .Info)
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        // this overrides everything you have set up earlier.
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .black
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        // to make everything work normally
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UINavigationBar.appearance().tintColor = .systemGray4
    }
    
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
                                    if(currentPage != 0){
                                        showBanner = true
                                        bannerData = stockBannerInfo
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                            withAnimation {
                                                self.showBanner = false
                                            }
                                        }
                                    }
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
                                    if(currentPage != 0){
                                        showBanner = true
                                        bannerData = stockBannerInfo
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                            withAnimation {
                                                self.showBanner = false
                                            }
                                        }
                                    }
                                })
                        }
                    }.animation(.easeIn)
                    
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
                                    if(currentPage != 1){
                                        showBanner = true
                                        bannerData = cryptoBannerInfo
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                            withAnimation {
                                                self.showBanner = false
                                            }
                                        }
                                    }
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
                                    if(currentPage != 1){
                                        showBanner = true
                                        bannerData = cryptoBannerInfo
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                            withAnimation {
                                                self.showBanner = false
                                            }
                                        }
                                    }
                                })
                            
                        }
                    }.animation(.easeIn)
                }
                
                PageView(pages: [AssetWatchListPage(isCrypto: false), AssetWatchListPage(isCrypto: true)], currentPage: $currentPage)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .banner(data: $bannerData, show: $showBanner)
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
