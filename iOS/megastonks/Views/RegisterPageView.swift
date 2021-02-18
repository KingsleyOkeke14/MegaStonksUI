//
//  RegisterPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-01.
//

import SwiftUI

struct RegisterPageView: View {
    
    let myColors = MyColors()
    
    var currencies:[String] = ["USD", "CAD"]
    @State var firstNameText:String = ""
    @State var lastNameText:String = ""
    @State var emailAddressText:String = ""
    @State var passwordText:String = ""
    @State var confirmpasswordText:String = ""
    @State var termsIsChecked:Bool = false
    @State var termsandconditionsopened:Bool = false
    @State var errorMessage:String = ""
    
    
    @State private var selectedCurrency = "CAD"
    
    func toggle(){
        termsIsChecked.toggle()
        
    }
    
    func validateForm(){
        if(!termsandconditionsopened || !termsIsChecked){
            errorMessage = "Please read and accept the Terms and Conditions"
        }
        else{
            errorMessage = ""
        }
    }
    
    
    var body: some View {
        Color.black
            .ignoresSafeArea() // Ignore just for the color
            .overlay(
                VStack {
                    VStack{
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
                                    Text("Select Currency")
                                        .foregroundColor(MyColors().greenColor)
                                        .bold()
                                        .fontWeight(.heavy)
                                        .font(.title2)
                                }.padding(.horizontal)
                                HStack{
                                    ButtonSelectionView()
                                }
                                Spacer()
                            }
                        }
                        Spacer()
                        HStack{
                            if(termsandconditionsopened){
                                Button(action:toggle)
                                {
                                    Image(systemName: termsIsChecked ? "checkmark.square.fill" : "square")
                                        .scaleEffect(1.2)
                                        .foregroundColor(myColors.greenColor)
                                    
                                    
                                }
                            }
                            
                            
                            Button(action: {
                                termsandconditionsopened = true
                            })
                            {
                                Text("TERMS AND CONDITIONS")
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            
                        }
                        
                        Button(action: {
                            validateForm()
                        }, label: {
                            ButtonView(text: "Register", frameWidth: 200, frameHeight: 48)
                        })
                        if(!errorMessage.isEmpty){
                            Text(errorMessage)
                                .foregroundColor(.red)
                        }
                        
                        
                    }.padding()
                }
                
            )
    }
}

struct RegisterPageView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPageView()
    }
}

