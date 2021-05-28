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
                    Text("Stocks")
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                        .fontWeight(.heavy)
                        .bold()
                        .foregroundColor(myColors.greenColor)
                        .opacity(currentPage == 0 ? 1 : 0.6)
                        .onTapGesture(perform: {
                            impactMed.impactOccurred()
                        })
                    Text("Crypto")
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                        .fontWeight(.heavy)
                        .bold()
                        .foregroundColor(myColors.greenColor)
                        .opacity(currentPage == 1 ? 1 : 0.6)
                        .onTapGesture(perform: {
                            impactMed.impactOccurred()
                            
                        })
                }
                PageView(pages: [AssetWatchListPage(isCrypto: false), AssetWatchListPage(isCrypto: true)], currentPage: $currentPage)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
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
