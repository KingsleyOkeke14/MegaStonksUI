//
//  LoginPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-01-31.
//

import SwiftUI

struct LoginPageView: View {
    let myColors = MyColors()
    
    @State var emailText:String = ""
    @State var passwordText:String = ""
    @State var errorMessage:String = ""
    
    @State var formText1:String = ""
    @State var formText2:String = ""
    @State var formText3:String = ""
    
    @State var isLoading:Bool = false
    
    @EnvironmentObject var userAuth: UserAuth
    
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
    
    
    var body: some View {
        NavigationView{
                    VStack{
                        Image("megastonkslogo")
                            .scaleEffect(0.8)
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 40)
                        Spacer(minLength: 100)
                        
                        FormView(formField: "Email Address", formText: $emailText)
                            .onAppear(perform: {
                                emailText = userAuth.user.emailAddress.removingWhitespaces()
                            })
                        SecretFormView(formField: "Password", secretText: $passwordText)
                        Text(errorMessage)
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                            .foregroundColor(.red)
                            .bold()
                            .padding(.horizontal, 10)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            hideKeyboard()
                            isLoading = true
                            if(emailText.isEmpty || passwordText.isEmpty){
                                errorMessage = "Email or Address Field cannot be Empty. Please re-enter credentials"
                                isLoading = false
                            }
                            else if(!emailText.isValidEmail){
                                errorMessage = "Invalid Email Address"
                                isLoading = false
                            }
                            else{
                                isLoading = true
                                self.userAuth.login(email: emailText, password: passwordText) { authResponse in
                                    errorMessage = authResponse.errorMessage
                                    isLoading = false
                                }
                            }
                        }, label: {
                            ButtonView(text: "Login", textSize: 22, frameWidth: 140, frameHeight: 34)
                            
                            
                        })
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                NavigationLink(
                                    destination: ForgotPasswordPageView(emailField: "").preferredColorScheme(.dark)){
                                    Text("Forgot Password?")
                                        .bold()
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                        .foregroundColor(.red)
                                        .underline()
                                        .padding()
                                        .padding(.trailing)
                                    
                                }
                                
                            }
                            HStack{
                                Spacer()
                                NavigationLink(
                                    destination: RegisterPageView().preferredColorScheme(.dark)){
                                    
                                    
                                    Text("Register")
                                        .bold()
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 28))
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding()
                                        .padding(.trailing)
                                    
                                }
                            }
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    defaults.setValue(true, forKey: "isInChatMode")
                                    userAuth.isInChatMode = true
                                    
                                }, label: {
                                    Label("Chat with the app developer", systemImage: "bubble.left")
                                        
                                        .foregroundColor(myColors.greenColor)
                                        .font(.system(size: 16, weight: .bold, design: .default))
                                })
                                Spacer()
                            }
                            Spacer()
                        }
                        
                    }
                    .overlay(
                        
                        VStack{
                            if(isLoading){
                                LoadingIndicatorView()
                            } 
                        }
                    )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("Login")
                .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
            .preferredColorScheme(.dark)
            .environmentObject(UserAuth())
        
    }
}
