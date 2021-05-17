//
//  RegisterPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-01.
//

import SwiftUI

struct RegisterPageView: View {
    
    let myColors = MyColors()
    
    @State private var firstNameText:String = ""
    @State private var lastNameText:String = ""
    @State private var emailAddressText:String = ""
    @State private var passwordText:String = ""
    @State private var confirmpasswordText:String = ""
    @State private var termsIsChecked:Bool = false
    @State private var termsandconditionsopened:Bool = false
    
    @State private var showingSheet = false
    
    @State private var selectedCurrency = "CAD"
    
    
    @State private var promptText:String = ""
    @State private var isLoading:Bool = false
    @State private var registerCompleted:Bool = false
    
    var decoder = JSONDecoder()
    
    
    @Environment(\.presentationMode) var presentation
    
    
    func toggle(){
        termsIsChecked.toggle()
    }
    
    func validateForm() -> Bool{
        if(firstNameText.isEmpty || lastNameText.isEmpty){
            promptText = "First Name and Last Name fields cannot be empty"
            return false
        }
        else if(!termsandconditionsopened || !termsIsChecked){
            promptText = "You must read and accept the Terms and Conditions to Register"
            return false
        }
        else if(!emailAddressText.isValidEmail){
            promptText = "Please Enter a Valid Email Address"
            return false
        }
        else if(passwordText.count < 6){
            promptText = "Password Length must be greater than 5 characters"
            return false
        }
        else if(passwordText != confirmpasswordText){
            promptText = "Password Field and Confirm Password Field do not match"
            return false
        }
        else{
            promptText = ""
            return true
        }
    }
    
    
    var body: some View {
        Color.black
            .ignoresSafeArea() // Ignore just for the color
            .overlay(
                VStack {
                    if(!registerCompleted){
                        VStack {
                            ScrollView {
                           
                                    Image("megastonkslogo")
                                        .scaleEffect(0.8)
                                        .aspectRatio(contentMode: .fit)
                                    
                                    VStack(spacing: 2){
                                        
                                        
                                        FormView(formField: "First Name", formText: $firstNameText)
                                        FormView(formField: "Last Name", formText: $lastNameText)
                                        FormView(formField: "Email Address", formText: $emailAddressText)
                                        
                                        
                                        
                                        SecretFormView(formField: "Password", secretText: $passwordText)
                                        SecretFormView(formField: "Confirm Password", secretText: $confirmpasswordText)
                                        VStack{
                                            HStack{
                                                Text("Select Currency (\(selectedCurrency))")
                                                    .foregroundColor(MyColors().greenColor)
                                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                                    .bold()
                                            }.padding(.horizontal)
                                            HStack{
                                                ButtonSelectionView(activeSelction: $selectedCurrency, buttonColor: myColors.greenColor)
                                            }
                                        }
                                    }.padding(.horizontal, 10)
                                    Spacer(minLength: 14)
                                    HStack{
                                        if(termsandconditionsopened){
                                            Button(action: toggle)
                                            {
                                                Image(systemName: termsIsChecked ? "checkmark.square.fill" : "square")
                                                    .foregroundColor(myColors.greenColor)
                                            }
                                        }
                                        
                                        Button(action: {
                                            hideKeyboard()
                                            termsandconditionsopened = true
                                            showingSheet.toggle()
                                        })
                                        {
                                            Text("TERMS AND CONDITIONS")
                                                .bold()
                                                .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                                .foregroundColor(.white)
                                        }
                                        .sheet(isPresented: $showingSheet) {
                                            SheetView()
                                        }
                                    }
                                
                                Text(promptText)
                                    .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                                    .foregroundColor(.red)
                                    .bold()
                                    .padding(.horizontal, 10)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 10)
                                Spacer(minLength: 18)
                                Button(action: {
                                    
                                    promptText = ""
                                    hideKeyboard()
                     
                                    let validationResult = validateForm()
                                    if(validationResult){
                                        isLoading = true
                                        API().Register(firstName: firstNameText, lastName: lastNameText, email: emailAddressText, password: passwordText, confirmPassword: confirmpasswordText, currency: selectedCurrency, acceptTerms: termsIsChecked){ result in

                                            if(result.isSuccessful){
                                                //I use the forgotpassword response here because it has the same format as the register response
                                                let jsonResponse = try! decoder.decode(CommonAPIResponse.self, from: result.data!)
                                                promptText = jsonResponse.message + " Please check the spam folder if you dont find the email in your inbox"
                                            }
                                            else{
                                                promptText = result.errorMessage
                                            }

                                            isLoading = false
                                            registerCompleted = true
                                        }
                                          
                                    }
                                    
                                    
                                    
                                }, label: {
                                    ButtonView(text: "Register", textSize: 22, frameWidth: 140, frameHeight: 34)
                                })
                            }
                        }.overlay(
                            VStack{
                                if(isLoading){
                                    LoadingIndicatorView()
                                }
                                
                            }
                        )
   
                    }
                    else{
                        VStack{
                            Image("megastonkslogo")
                                .scaleEffect(0.8)
                                .aspectRatio(contentMode: .fit)
                            Spacer()
                            Text(promptText)
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 16))
                                .foregroundColor(.white)
                                .bold()
                                .padding(.horizontal, 10)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        
                    }
                }

                
            )
            .navigationBarTitleDisplayMode(.inline)
    }
}


struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    
    let myColors = MyColors()
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack{
                    ScrollView{
                        VStack{
                            Spacer()
                            Text("Terms and Conditions")
                                .bold()
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                .foregroundColor(myColors.greenColor)
                            Spacer()
                            Text(EULA().eula)
                                .bold()
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }.padding(.horizontal, 20)
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            
                        }, label: {
                            Text("Press to Dismiss")
                                .bold()
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                                .foregroundColor(myColors.greenColor)
                        })
                        
                        
                    }
                }
            )
        
    }
}


struct RegisterPageView_Previews: PreviewProvider {
    static var previews: some View {
        //SheetView()
        RegisterPageView()
    }
}

