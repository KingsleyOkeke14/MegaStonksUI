//
//  ProfileSettingsPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-11.
//

import SwiftUI

struct ProfileSettingsPageView: View {
    
    @State var isLoading:Bool = false
    
    @EnvironmentObject var userAuth: UserAuth
    
    @Environment(\.presentationMode) var presentation
    
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
    

    
    let myColors = MyColors()
    var body: some View {
        
        VStack {
            Color.black
                .ignoresSafeArea()
                .overlay(
                    ScrollView{
                        VStack{
                            Image("megastonkslogo")
                                .scaleEffect(0.6)
                                .aspectRatio(contentMode: .fit)
                            HStack{
                                Image(systemName: "gear")
                                    .foregroundColor(.green)
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                                Text("Account Settings")
                                    .foregroundColor(.white)
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
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
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 26))
                                Text("MegaStonks is a product offered by Striking Credit and is Striking Credit's first step in empowering individuals with tools to better understand and take control of their personal finances")
                                    .foregroundColor(.gray)
                                    .bold()
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                    .multilineTextAlignment(.center)
                                    .padding()
                                Text("strikingcredit.ca")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                Text("Version 5.4.2.0")
                                    .foregroundColor(myColors.greenColor)
                                    .bold()
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                    .padding()
                            }
                            Spacer()
                            HStack{
                                Button(action: {
                                    isLoading = true
                                    userAuth.logout()
                                    isLoading = false
                                    
                                },
                                label: {
                                    ButtonView(text: "LogOut", textSize: 20, strokeLineWidth: 1, frameWidth: 100, frameHeight: 40)
                                })
                                
                            }
                            
                            
                        }.padding()
                    }
                )
        }.overlay(
            
            VStack{
                if(isLoading){
                    LoadingIndicatorView()
                }
                
            }
        )
        .navigationBarTitleDisplayMode(.inline)
        
        
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
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                Spacer()
            }
            HStack {
                Text(info)
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                    .foregroundColor(.gray)
                Spacer()
                if(isEditable){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "pencil")
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                            .foregroundColor(.green)
                    })
                }
                else{
                    Image(systemName: "pencil")
                        .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
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



