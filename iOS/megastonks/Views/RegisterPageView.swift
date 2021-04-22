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
    
    @State private var showingSheet = false
    
    @State private var selectedCurrency = "CAD"
    
    @Environment(\.presentationMode) var presentation
    
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
                ScrollView {
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
                                           .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                                            .bold()
                                    }.padding(.horizontal)
                                    HStack{
                                        ButtonSelectionView()
                                    }
                                    if(!errorMessage.isEmpty){
                                        Text(errorMessage)
                                            .foregroundColor(.red)
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
                            
                            Button(action: {
                                hideKeyboard()
                                validateForm()
                            }, label: {
                                ButtonView(text: "Register", textSize: 22, frameWidth: 140, frameHeight: 34)
                            })

                            
                            
                        }.padding()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                
            )
    }
}


struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                
                Button("Press to dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.title)
                .padding()
                .background(Color.black)
            
            )

    }
}

struct RegisterPageView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPageView()
    }
}

