//
//  ResetPasswordPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-14.
//

import SwiftUI

struct ResetPasswordPageView: View {
    
    let myColors = MyColors()
    @State var isLoading:Bool = false
    
    @State var formText1:String = ""
    @State var formText2:String = ""
    @State var formText3:String = ""
    
    @State var promptText:String = ""
    @State var isPromptError:Bool = false
    
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View {
        VStack {
            Color.black
                .ignoresSafeArea()
                .overlay(
                    VStack{
                            FormView(formField: "Reset Token", formText: $formText1)
                            
                            SecretFormView(formField: "New Password", secretText: $formText2)
                            SecretFormView(formField: "Confirm Password", secretText: $formText3)
                        
                      
                        PromptView(promptText: $promptText, isError: $isPromptError)
                        Button(action: {
                                hideKeyboard()
                                isLoading = true
                            API().ResetPassword(token: formText1, newpassword: formText2, confirmPassword: formText3){ result in
                                
                                if(result.isSuccessful){
                                    promptText = "Password Reset Successful. Please Login with your new Password"
                                    isPromptError = false
                                    
                                    if(userAuth.isLoggedin!){
                                        userAuth.logout(){
                                            result in
                                            
                                            if(result.isSuccessful){
                                                DispatchQueue.main.async {
                                                    userAuth.isLoggedin = false
                                                }
                                            }
                                        }
                                    }
                                }
                                else{
                                    promptText = result.errorMessage
                                    isPromptError = true
                                }
                                isLoading = false
                            }
                            
                            
                        },
                               label: {
                            ButtonView(text: "Update", textSize: 20, frameWidth: 120, frameHeight: 40)
                        }).padding()
                        if(userAuth.isLoggedin!){
                            Text("You will be logged out on Successfull Password Reset")
                                .foregroundColor(myColors.greenColor)
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                .multilineTextAlignment(.center)
                        }

                    }.padding(.horizontal)
                    
                )
        }.overlay(
        
            VStack{
                if(isLoading){
                    LoadingIndicatorView()
                }

            }
        )
        .navigationBarHidden(true)
    }
}

struct ResetPasswordPageView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordPageView().environmentObject(UserAuth())
    }
}
