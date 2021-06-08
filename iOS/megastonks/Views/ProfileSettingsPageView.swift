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

    @State var errorMessage: String = ""
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.openURL) var openURL
    
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
    
    let myColors = MyColors()
    var body: some View {
        NavigationView{
        VStack {
            Color.black
                .ignoresSafeArea()
                .overlay(
                    ScrollView{
                        VStack(spacing: 2){
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
                            }
                            ProfileInformationView(infoHeader: "Email Address", info: userAuth.user.emailAddress, isEditable: false)
                            ProfileInformationView(infoHeader: "Currency", info: userAuth.user.currency, isEditable: false)
                            ProfileInformationView(infoHeader: "Password", info: "***********", isEditable: true)
                            
                            
                            VStack(spacing: 0.5){
                                HStack{
                                    Text("Notifications")
                                        .foregroundColor(myColors.greenColor)
                                        .bold()
                                        .fontWeight(.heavy)
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                    Spacer()
                                    Button(action: {
                                        if let bundleIdentifier = Bundle.main.bundleIdentifier, let appSettings = URL(string: UIApplication.openSettingsURLString + bundleIdentifier) {
                                            if UIApplication.shared.canOpenURL(appSettings) {
                                                UIApplication.shared.open(appSettings)
                                            }
                                        }
                                    }, label: {
                                        Image(systemName: "pencil")
                                            .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                            .foregroundColor(.green)
                                        
                                })
                                }
                                
                                Rectangle()
                                    .fill(myColors.greenColor)
                                    .frame(height: 2)
                                    .edgesIgnoringSafeArea(.horizontal)
                                
                            }.padding(.vertical)
                            
                            VStack(spacing:1){
                                Text("About Us")
                                    .foregroundColor(myColors.greenColor)
                                    .bold()
                                    .fontWeight(.heavy)
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 26))
                                Text("MegaStonks is a product offered by Striking Financial and is Striking Financial's first step in empowering individuals with tools and resources to better understand and take control of their personal finances")
                                    .foregroundColor(.gray)
                                    .bold()
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                    .multilineTextAlignment(.center)
                                    .padding()
                                Text("Follow our social accounts below")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                                
                                HStack{
                                    Button(action: {
                                        openURL(URL(string: "https://twitter.com/MegaStonksApp")!)
                                    }, label: {
                                        Image("twitterLogo")
                                            .resizable()
                                            .frame(width: 40, height: 36)
                                            .padding(.horizontal)
                                      
                                    })
                                    
                                    Button(action: {
                                        openURL(URL(string: "https://www.instagram.com/megastonksapp")!)
                                        
                                    }, label: {
                                        Image("instagramLogo")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .padding(.horizontal)
                                           
                                    })
                                }
                                Button(action: {
                                    openURL(URL(string: "https://www.megastonks.com")!)
                                }, label: {
                                    Text("megastonks.com")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                        .padding(.top)
                                })
                               
                                Text("Version 1.2.0")
                                    .foregroundColor(myColors.greenColor)
                                    .bold()
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                    .padding()
                                
                                if(!errorMessage.isEmpty){
                                    Text(errorMessage)
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                        .foregroundColor(.red)
                                        .bold()
                                        .padding(.horizontal, 10)
                                }
                            }
                            Spacer()
                            HStack{
                                Button(action: {
                                    isLoading = true
                                    userAuth.logout(){ result in
                                        if(result.isSuccessful){
                                            isLoading = false
                                            DispatchQueue.main.async {
                                                userAuth.isLoggedin = false
                                            }
                                        }
                                        else{
                                            isLoading = false
                                            errorMessage = result.errorMessage
                                        }
                                    }
                                    
                                    
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
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProfileInformationView: View {
    let myColors = MyColors()
    var infoHeader:String
    var info:String
    var isEditable:Bool
    
    @EnvironmentObject var userAuth: UserAuth
    
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
                    NavigationLink(
                        destination: ForgotPasswordPageView(emailField: userAuth.user.emailAddress).navigationBarTitle("").navigationBarHidden(true),
                        label: {
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
            
        }.padding(.vertical)
    }
}

struct ProfileSettingsPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsPageView().environmentObject(UserAuth())
    }
}



