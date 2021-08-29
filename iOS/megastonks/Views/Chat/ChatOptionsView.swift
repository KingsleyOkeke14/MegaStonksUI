//
//  ChatOptionsView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-08-26.
//

import SwiftUI

struct ChatOptionsView: View {
    let myColors = MyColors()
    
    @Environment(\.openURL) var openURL
    @EnvironmentObject var userAuth: UserAuth
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack{
                    VStack{
                        
                    }.frame(height: 70)
                    ScrollView{
                        VStack{
                            
                        }.frame(height: 20)
                        ZStack {
                            Circle()
                                .stroke(myColors.greenColor, lineWidth: 4)
                                .frame(width: 80, height: 80)
                            AsyncImage(url: URL(string: "https://kingsleyokeke.blob.core.windows.net/images/1597276037537.jpeg")!,
                                       placeholder: { Image("blackImage") },
                                       image: { Image(uiImage: $0).resizable() })
                                .frame(width: 80, height: 80, alignment: .center)
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fill)
                                .shadow(radius: 8)
                        }.padding(.horizontal)
                        
                        Text("Kingsley Okeke")
                            .font(.custom("Helvetica", fixedSize: 16))
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Founder and Principal Developer")
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                            .bold()
                            .foregroundColor(.black)
                            .padding(2)
                            .padding(.horizontal, 6)
                            .background(myColors.greenColor.opacity(0.8))
                            .cornerRadius(20)
                            
                        Text("Hello there, thank you for downloading the mega stonks app. I am looking forward to chatting with you and helping you understand your financial situation and discussing ways to improve and continue growing. I am really passionate about personal finance and developing tools for individuals to understand and take better control of their finances. My goal is effectively aimed at bridging the ever widening wealth gap and inequality. Feel free to follow me on my social accounts below. Thanks!")
                            .font(.custom("", fixedSize: 16))
                            .padding()
                            .padding(.horizontal, 1)
                            .background(myColors.grayColor.opacity(0.6))
                            .cornerRadius(20)
                        
                        HStack{
                            Button(action: {
                                openURL(URL(string: "https://twitter.com/ke_kakes")!)
                            }, label: {
                                Image("twitterLogo")
                                    .resizable()
                                    .frame(width: 40, height: 36)
                                    .padding(.horizontal)
                              
                            })
                            
                            Button(action: {
                                openURL(URL(string: "https://www.instagram.com/ke_kakes")!)
                                
                            }, label: {
                                Image("instagramLogo")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .padding(.horizontal)
                                   
                            })
                        }
                        VStack{
                            
                        }.frame(height: 40)
                        HStack{
                            Button(action: {
                                
                                userAuth.isChatLoggedIn = false
                                
                            }, label: {
                                Text("Close Chat Session")
                                    .font(.custom("Helvetica", fixedSize: 16))
                                    .bold()
                                    .foregroundColor(.black)
                                    .padding(2)
                                    .padding(.horizontal, 6)
                                    .background(Color.red.opacity(0.8))
                                    .cornerRadius(20)
                                    
                            })
                        }.padding()
                        
                        Button(action: {
                            userAuth.isInChatMode = false
                        }, label: {
                            HStack {
                                
                                Image(systemName: "arrow.backward.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.custom("", fixedSize: 22))
                                    
                                Text("Exit To Main App")
                                    .font(.custom("", fixedSize: 18))
                                    .foregroundColor(.green)
                                    .bold()
                                    .padding(.trailing)

                            }.padding()
                        })
                    }
                    
                }
            )
    }
}

struct ChatOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatOptionsView()
            .preferredColorScheme(.dark)
            .environmentObject(UserAuth())
    }
}
