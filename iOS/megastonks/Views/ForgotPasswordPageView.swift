//
//  ForgotPasswordPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-14.
//

import SwiftUI

struct ForgotPasswordPageView: View {

    

    
    let myColors = MyColors()
    
    @Environment(\.presentationMode) var presentation
    
    @State var formText1:String
    @State var promptText:String = ""
    @State var isPromptError:Bool = false
    
    @State var isLoading:Bool = false
    
    @EnvironmentObject var userAuth: UserAuth
    
    let decoder = JSONDecoder()
    
    
    init(emailField: String) {
        _formText1 = State(initialValue: emailField)
    }
    
    var body: some View {
                VStack(spacing: 40){

                    VStack {
                            FormView(formField: "Email Address", formText: $formText1)
    
                            PromptView(promptText: $promptText, isError: $isPromptError)
                        
                        Button(action: {
                            hideKeyboard()
                            promptText = ""
                            if(formText1.isEmpty){
                                promptText = "Please Enter a Valid Email Address to Request a Reset Token"
                                isPromptError = true
                            }
                            else{
                                isLoading = true
                                API().ForgotPassword(emailAddress: formText1){ result in
                                    
                                    if(result.isSuccessful){
                                        
                                    

                                        promptText = "Please check your email for the password reset token then click on \"Reset Password\" below to continue"
                                        isPromptError = false
                                    }
                                    else{
                                        promptText = result.errorMessage
                                        isPromptError = true
                                    }
                                    isLoading = false
                                }

                            }
                            
                        }, label: {
                            ButtonView(text: "Request Token",  textSize: 20, frameWidth: 160, frameHeight: 40)
                        })
                    }

           
                  NavigationLink(
                    destination: ResetPasswordPageView().preferredColorScheme(.dark),
                    label: {
                        HStack{
                            Spacer()
                                Text("Reset Password")
                                    .bold()
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 22))
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                    .padding(.trailing)
                        }
                    })
                    
                }.overlay(
                    
                    VStack{
                        if(isLoading){
                            LoadingIndicatorView()
                        }
                        
                    }
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("")
                
    }
}

struct ForgotPasswordPageView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordPageView(emailField: "").environmentObject(UserAuth())
    }
}
