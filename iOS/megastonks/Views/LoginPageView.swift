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
        
        UINavigationBar.appearance().tintColor = .green
    }
    
    
    var body: some View {
        NavigationView{
            Color.black
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                    
                    VStack{
                        Image("megastonkslogo")
                            .scaleEffect(0.8)
                            .aspectRatio(contentMode: .fit)
                        Spacer(minLength: 80)
                        
                        FormView(formField: "Email Address", formText: $emailText)
                        SecretFormView(formField: "Password", secretText: $passwordText)
                        Text(errorMessage)
                            .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                            .foregroundColor(.red)
                            .bold()
                            .padding(.horizontal, 10)
                        
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
                                    destination: ForgotPasswordPageView()){
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
                                    destination: RegisterPageView()){
                                    
                                    
                                    Text("Register")
                                        .bold()
                                        .font(.custom("Apple SD Gothic Neo", fixedSize: 28))
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding()
                                        .padding(.trailing)
                                }
                                
                                
                                
                            }
                            
                            
                            Spacer()
                        }
                        
                        
                    }.padding()
                    .overlay(
                        
                        VStack{
                            if(isLoading){
                                LoadingIndicatorView()
                            }
                            
                            
                            
                            
                        }
                    )
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("Login")
                .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
        
    }
}
