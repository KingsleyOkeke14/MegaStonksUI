//
//  ProfilePageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-10.
//

import SwiftUI

struct ProfilePageView: View {
    let myColors = MyColors()
    var percentage:CGFloat = 0.3
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        
        // this overrides everything you have set up earlier.
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .black
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        // to make everything work normally
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UINavigationBar.appearance().tintColor = .green
    }
    
    var body: some View {
        NavigationView{
            Color.black
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                    VStack(spacing: 12){
                        
                        HStack{
                            Text("Account")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                                .fontWeight(.heavy)
                                .bold()
                                .foregroundColor(myColors.greenColor)
                                .padding(.horizontal)
                            Spacer()
                        }

                        HStack{
                            Spacer()
                            NavigationLink(
                                destination: ProfileSettingsPageView()){
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 24))
                                    .foregroundColor(Color.green)
                            }.padding(.horizontal)
                        
                        }
                        
                        
                        HStack {
                            
                            Text("$100,000.04")
                                .foregroundColor(myColors.greenColor)
                                .font(.custom("Verdana", fixedSize: 20))
                                .bold()
                                +
                                Text(" CAD")
                                .foregroundColor(myColors.greenColor)
                                .font(.custom("Verdana", fixedSize: 12))
                                .bold()
                                .baselineOffset(-0.4)
                            
                        }
                        
                        UserProfileWalletSummary()
                        
                        
                        
                        Button(action: {}, label: {
                            VStack(spacing: 0) {
                                
                                HStack {
                                    Text("Orders")
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                                        .bold()
                                        .foregroundColor(myColors.greenColor)
                                    
                                    Spacer()
                                    Image(systemName: "chevron.forward.circle")
                                        .foregroundColor(myColors.greenColor)
                                    
                                }
                                Rectangle()
                                    .fill(myColors.greenColor)
                                    .frame(height: 2)
                                    .edgesIgnoringSafeArea(.horizontal)
                                
                            }.padding(.horizontal)
                        })
                        
                        OrderView().padding(.top, 10)
                        Spacer()
                        
                    }
                    
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        
        
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RadialWalletView: View {
    var body: some View {
        ZStack{
            Image("megastonkslogo")
                .scaleEffect(0.3)
                .aspectRatio(contentMode: .fit)
            RadialChartView(percentage: 0.4, width: 100, height: 100, lineWidth: 6, lineCapStyle: CGLineCap.square)
        }.padding(.horizontal, -20)
    }
}



struct UserProfileWalletSummary: View {
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                RadialWalletView()
            }
            VStack(alignment: .leading){
                Text("KINGSLEY")
                    .font(.custom("Marker Felt", fixedSize: 20))
                    .bold()
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Text("OKEKE")
                    .font(.custom("Marker Felt", fixedSize: 20))
                    .bold()
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                HStack{
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.green)
                    Text("CASH:")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 12))
                    Spacer()
                    Text("$40,000")
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom("Verdana", fixedSize: 12))
                }.lineLimit(1).minimumScaleFactor(0.8)
                HStack{
                    Circle()
                        .opacity(0.3)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.green)
                    Text("INVESTMENTS:")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 12))
                    Spacer()
                    Text("$60,0000")
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom("Verdana", fixedSize: 12))
                }.lineLimit(1).minimumScaleFactor(0.8)
                HStack{
                    Circle()//This is not visible. Just there to ensure the same space with Investments Text
                        .opacity(0)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.green)
                    Text("Initial Deposit:")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", fixedSize: 12))
                    Spacer()
                    Text("$80,000")
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom("Verdana", fixedSize: 12))
                }.lineLimit(1).minimumScaleFactor(0.8)
            }.padding(.trailing)
        }
    }
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}

