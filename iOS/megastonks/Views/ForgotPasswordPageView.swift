//
//  ForgotPasswordPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-14.
//

import SwiftUI

struct ForgotPasswordPageView: View {

    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        
        // this overrides everything you have set up earlier.
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .black
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        // to make everything work normally
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
    }
    
    let myColors = MyColors()
    
    @Environment(\.presentationMode) var presentation
    
    @State var formText1:String = ""
    @State var promptText:String = ""
    @State var isPromptError:Bool = false
    
    var body: some View {
       NavigationView{
        Color.black
            .ignoresSafeArea(.all)
            .overlay(
                VStack(spacing: 40){

                    VStack {
                        FormView(formField: "Email Address", formText: $formText1)
                        
                            PromptView(promptText: $promptText, isError: $isPromptError)
                        

                        Button(action: {
                            hideKeyboard()
                            if(formText1.isEmpty){
                                promptText = "Please Enter a Valid Email Address to Request a Reset Token"
                                isPromptError = true
                            }
                            else{
                                promptText = "Please Check your Email for the Reset Token. Click on Reset Password to Continue"
                                isPromptError = false
                            }
                            
                        }, label: {
                            ButtonView(text: "Request Token",  textSize: 20, frameWidth: 160, frameHeight: 40)
                        })
                    }

           
                  NavigationLink(
                    destination: ResetPasswordPageView(),
                    label: {
                        HStack{
                            Spacer()
                                Text("Reset Password")
                                    .bold()
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 28))
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                    .padding(.trailing)
                        }
                    })
                    
                    NavigationLink(
                      destination: LoginPageView(),
                      label: {
                        HStack(spacing:1){
                              Spacer()
                                 Image(systemName: "arrow.backward.circle")
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                    .foregroundColor(myColors.greenColor)
                                  Text("Back to Login")
                                      .bold()
                                      .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                      .bold()
                                    .foregroundColor(myColors.greenColor)
                                      .padding()
                                      .padding(.trailing)
                        }
                      })
                    
                }
            )
            
            
        }.navigationBarHidden(true)
       .navigationBarBackButtonHidden(true)
       .navigationBarTitle("")
       .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ForgotPasswordPageView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordPageView()
    }
}

struct PromptView: View {
    
    @Binding var promptText:String
    @Binding var isError:Bool
    
    var body: some View {
        if(isError){
            Text(promptText)
                .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                .foregroundColor(.red)
                .bold()
                .padding(.horizontal, 10)
                .multilineTextAlignment(.center)
        }
        else{
            Text(promptText)
                .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                .foregroundColor(.white)
                .bold()
                .padding(.horizontal, 10)
                .multilineTextAlignment(.center)
        }

    }
}
