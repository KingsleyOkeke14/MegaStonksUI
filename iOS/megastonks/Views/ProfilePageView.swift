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
    
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack{
                    HStack{
                        Spacer()
                        Button(action: {}, label: {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.title)
                                .foregroundColor(Color.green)
                        }).padding(.horizontal)
                    }
                    Spacer()
                    UserProfileWalletSummary()
                    Rectangle()
                        .fill(myColors.greenColor)
                        .frame(height: 2)
                        .edgesIgnoringSafeArea(.horizontal)
                        .padding(.horizontal)
                        .padding(.vertical, 40)
                    HStack {
                        Text("$24,000.04")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", size: 34))
                            .bold()
                            +
                            Text(" CAD")
                            .foregroundColor(.white)
                            .font(.custom("Verdana", size: 20))
                            .bold()
                            .baselineOffset(0)
                        
                    }
                    ChartView(chartButtonList: [("1D", true), ("5D", false), ("1M", false), ("3M", false), ("1Y", false), ("ALL", false)])
                    Spacer()
                }
                
                
                
            )
    }
}

struct RadialWalletView: View {
    var body: some View {
        ZStack{
            Image("megastonkslogo")
                .scaleEffect(0.4)
                .aspectRatio(contentMode: .fit)
            RadialChartView(percentage: 0.4, width: 140, height: 140, lineWidth: 8, lineCapStyle: CGLineCap.square)
        }
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
                    .font(.custom("Marker Felt", size: 30))
                    .bold()
                    .foregroundColor(.white)
                Text("OKEKE")
                    .font(.custom("Marker Felt", size: 30))
                    .bold()
                    .foregroundColor(.white)
                HStack{
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.green)
                    Text("CASH:")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", size: 12))
                    Spacer()
                    Text("$40,000")
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom("Verdana", size: 12))
                }
                HStack{
                    Circle()
                        .opacity(0.3)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.green)
                    Text("INVESTMENTS:")
                        .foregroundColor(.white)
                        .font(.custom("Verdana", size: 12))
                    Spacer()
                    Text("$60,000")
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom("Verdana", size: 12))
                }
                HStack{
                    Circle()//This is not visible. Just there to ensure the same space with Investments Text
                        .opacity(0)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.green)
                    Text("TOTAL:")
                        .foregroundColor(.white)
                        
                        .font(.custom("Verdana", size: 12))
                    Spacer()
                    Text("$100,000")
                        .foregroundColor(.white)
                        .bold()
                        .font(.custom("Verdana", size: 12))
                }
            }.padding(.trailing)
        }
    }
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}

