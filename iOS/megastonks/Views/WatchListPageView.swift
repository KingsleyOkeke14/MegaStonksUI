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
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

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
                            Text("Stocks")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                .fontWeight(.heavy)
                                .bold()
                                .foregroundColor(myColors.greenColor)
                                .opacity(currentPage == 0 ? 1 : 0.4)
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
                            Image(systemName: "circle.fill")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 6))
                                .foregroundColor(currentPage == 0 ? myColors.greenColor : Color.black)
                                .padding(.top, -10)
                                
                        }.animation(.easeIn)
                            
                        VStack{
                            Text("Crypto")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                .fontWeight(.heavy)
                                .bold()
                                .foregroundColor(myColors.greenColor)
                                .opacity(currentPage == 1 ? 1 : 0.4)
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
                            Image(systemName: "circle.fill")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 6))
                                .foregroundColor(currentPage == 1 ? myColors.greenColor : Color.black)
                                .padding(.top, -10)
                                
                        }.animation(.easeIn)
                        
                    }.padding(.bottom, -10)
                    
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
