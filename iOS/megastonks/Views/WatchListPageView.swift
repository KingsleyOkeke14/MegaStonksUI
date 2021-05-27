//
//  WatchListPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-26.
//

import SwiftUI

struct WatchListPageView: View {
    
    let myColors = MyColors()
    @State private var selection = 0
    @EnvironmentObject var userAuth:UserAuth
    @EnvironmentObject var myAppObjects:AppObjects
    
    
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
        
        let color = UIView()
        color.backgroundColor = .systemGray6
        UITableViewCell.appearance().selectedBackgroundView = color
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
                    .opacity(selection == 1 ? 0.6 : 1.0)
                Text("Crypto")
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                    .fontWeight(.heavy)
                    .bold()
                    .foregroundColor(myColors.greenColor)
                    .opacity(selection == 0 ? 0.6 : 1.0)
            }.padding(.horizontal)
                TabView(selection: $selection) {
                    StocksWatchListPageView().tag(0)
                    CryptoWatchListPageView().tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
                
            }.navigationBarTitleDisplayMode(.inline)
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
