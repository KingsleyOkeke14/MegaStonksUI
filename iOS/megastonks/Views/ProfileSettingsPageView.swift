//
//  ProfileSettingsPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-11.
//

import SwiftUI

struct ProfileSettingsPageView: View {
    
    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
    
    @State var isLoading:Bool = false
    @State var showDeleteAccountConfirmation:Bool = false
    @State var promptOpacity:Bool = false
    
    @EnvironmentObject var userAuth: UserAuth

    @State var errorMessage: String = ""
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.openURL) var openURL
    
    
    let myColors = MyColors()
    var body: some View {
        VStack {
                    ScrollView{
                        VStack(spacing: 2){
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
                            ProfileInformationView(infoHeader: "Password", info: "***********", isEditable: true).onTapGesture {
                                showDeleteAccountConfirmation = false
                            }
                            
                            VStack(spacing: 0.5){
                                HStack{
                                    Text("Notifications")
                                        .foregroundColor(myColors.greenColor)
                                        .bold()
                                        .fontWeight(.heavy)
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                    Spacer()
                                    Button(action: {
                                        showDeleteAccountConfirmation = false
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
                            
//                            Button(action: {
//                                impactMed.impactOccurred()
//                                showDeleteAccountConfirmation.toggle()
//                            }, label: {
//                                ButtonView(cornerRadius: 12,  text: "Delete Account", textColor: myColors.lightGrayColor, textSize: 16, frameWidth: 120, frameHeight: 40, strokeBorders: false, fillColor: myColors.grayColor)
//                            }).padding()
                            
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
                                        showDeleteAccountConfirmation = false
                                        openURL(URL(string: "https://twitter.com/MegaStonksApp")!)
                                    }, label: {
                                        Image("twitterLogo")
                                            .resizable()
                                            .frame(width: 40, height: 36)
                                            .padding(.horizontal)
                                      
                                    })
                                    
                                    Button(action: {
                                        showDeleteAccountConfirmation = false
                                        openURL(URL(string: "https://www.instagram.com/megastonksapp")!)
                                        
                                    }, label: {
                                        Image("instagramLogo")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .padding(.horizontal)
                                           
                                    })
                                }
                                Button(action: {
                                    showDeleteAccountConfirmation = false
                                    openURL(URL(string: "https://www.megastonks.com")!)
                                }, label: {
                                    Text("megastonks.com")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 12))
                                        .padding(.top)
                                })
                               
                                Text("Version 2.0.2")
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
                                    showDeleteAccountConfirmation = false
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
        }.onTapGesture {
            showDeleteAccountConfirmation = false
        }
        .overlay(
            
            VStack{
                if(isLoading){
                    LoadingIndicatorView()
                }
                if showDeleteAccountConfirmation {
                    ZStack {
                        myColors.grayColor
                        VStack {
                            Text("Confirm Account Deletion!")
                                .font(.custom("Verdana", fixedSize: 18))
                                .bold()
                                .bold()
                                .foregroundColor(.red)
                                .opacity(promptOpacity ? 0.2 : 1)
                                
                                .animation(Animation
                                            .easeInOut(duration: 0.5)
                                            .repeatForever(autoreverses: true))
                                .onAppear { promptOpacity.toggle() }
                               
                            Spacer()
                            Text("Are you sure you would like to delete your account? This process is not reversible and you would lose access to your data and account")
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                                .bold()
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action: {
                                    impactMed.impactOccurred()
                                    self.showDeleteAccountConfirmation = false
                                }, label: {
                                    
                                    Text("Yes")
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                        
                                        .foregroundColor(.red)
                                        .opacity(0.6)
                                })
                                Spacer()
                                Button(action: {
                                    impactMed.impactOccurred()
                                    self.showDeleteAccountConfirmation = false
                                }, label: {
                                    Text("No")
                                        .font(.custom("Verdana", fixedSize: 18))
                                        .bold()
                                        .foregroundColor(.green)
                                })
                                
                                Spacer()
                            }
                        }.padding()
                    }
                    .frame(width: 300, height: 200)
                    .cornerRadius(20).shadow(radius: 20)
                    .transition(AnyTransition.scale.animation(.easeInOut(duration: 0.5)))
                }
            }
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("")
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
                        destination: ForgotPasswordPageView(emailField: userAuth.user.emailAddress)
                            .preferredColorScheme(.dark),
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
        ProfileSettingsPageView()
            .preferredColorScheme(.dark)
            .environmentObject(UserAuth())
    }
}



