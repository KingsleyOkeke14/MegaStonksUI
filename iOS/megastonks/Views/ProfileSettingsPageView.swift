//
//  ProfileSettingsPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-11.
//

import SwiftUI

struct ProfileSettingsPageView: View {
    let myColors = MyColors()
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack{
                    Image("megastonkslogo")
                        .scaleEffect(0.6)
                        .aspectRatio(contentMode: .fit)
                    HStack{
                        Image(systemName: "gear")
                            .foregroundColor(.green)
                            .font(.title)
                        Text("Account Settings")
                            .foregroundColor(.white)
                            .font(.title)
                        Spacer()
                    }.padding()
                    ProfileInformationView(infoHeader: "Email Address", info: "Kingsleyokeke14@gmail.com", isEditable: false)
                    ProfileInformationView(infoHeader: "Currency", info: "USD", isEditable: false)
                    ProfileInformationView(infoHeader: "Password", info: "***********", isEditable: true)
                    Spacer()
                    VStack(spacing:1){
                        Text("About Us")
                            .foregroundColor(myColors.greenColor)
                            .bold()
                            .fontWeight(.heavy)
                            .font(.title)
                        Text("MegaStonks is a product offered by Striking Credit and is Striking Credit's first step in empowering individuals with tools to better understand and take control of their personal finances")
                            .foregroundColor(.gray)
                            .bold()
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                        Text("strikingcredit.ca")
                            .foregroundColor(.white)
                            .bold()
                            .font(.body)
                        Text("Version 5.4.2.0")
                            .foregroundColor(myColors.greenColor)
                            .bold()
                            .font(.title3)
                            .padding()
                    }
                   Spacer()
                    HStack{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            ButtonView(text: "LogOut", strokeLineWidth: 1)
                        })

                    }

                    
                }.padding()
            )

    }
}

struct ProfileInformationView: View {
    let myColors = MyColors()
    var infoHeader:String
    var info:String
    var isEditable:Bool
    
    var body: some View {
        VStack(spacing: 0.5){
            HStack{
                Text(infoHeader)
                    .foregroundColor(myColors.greenColor)
                    .bold()
                    .fontWeight(.heavy)
                    .font(.title2)
                Spacer()
            }
            HStack {
                Text(info)
                    .font(.custom("Apple SD Gothic Neo", size: 22))
                    .foregroundColor(.gray)
                Spacer()
                if(isEditable){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "pencil")
                            .font(.title2)
                            .foregroundColor(.green)
                    })
                }
                else{
                        Image(systemName: "pencil")
                            .font(.title2)
                            .foregroundColor(.gray)
                    
                }

                
            }
            
            Rectangle()
                .fill(myColors.greenColor)
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
            
            
        }.padding()
    }
}

struct ProfileSettingsPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsPageView()
    }
}



