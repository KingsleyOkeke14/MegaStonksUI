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
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack{
                    VStack{
                        
                    }.frame(height: 70)
                    ScrollView{
                        VStack{
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
                                .background(myColors.greenColor)
                                .cornerRadius(20)
                            Text("Hello there, thank you for downloading the mega stonks app. I am looking forward to chatting with you and helping you understand how to take control of your finances. Let's discuss anything from debt to asset management. I am really passionate about personal finance and developing tools for individuals to understand their financial options. My goal is aimed at bridging the ever widening wealth gap and inequality through financial education and tools. Feel free to follow me on my social accounts below. Thanks!")
                                .font(.custom("", fixedSize: 14))
                                .padding()
                                .padding(.horizontal, 20)
                                .multilineTextAlignment(.center)
                            
                            
                            HStack{
                                Button(action: {
                                    openURL(URL(string: "https://twitter.com/ke_kakes")!)
                                }, label: {
                                    Image("twitterLogo")
                                        .resizable()
                                        .frame(width: 40, height: 40)
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
                        }
                        
                        
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
