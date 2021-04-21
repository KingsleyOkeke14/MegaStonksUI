//
//  EditSelectionView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-11.
//

import SwiftUI

struct EditSelectionView: View {
    var formField1:String
    var formField2:String = ""
    var formField3:String = ""
    @State var isLoading:Bool = false
    
    @Binding var formText1:String
    @Binding var formText2:String
    @Binding var formText3:String
    var isSecret:Bool
    var body: some View {
        VStack {
            Color.black
                .ignoresSafeArea()
                .overlay(
                    VStack{
                        if(isSecret){
                            FormView(formField: formField1, formText: $formText1)
                            
                            SecretFormView(formField: formField2, secretText: $formText2)
                            SecretFormView(formField: formField3, secretText: $formText3)
                        }
                        else{
                            FormView(formField: formField1, formText: $formText1)
                        }
                        
                        Button(action: {
                                hideKeyboard()
                                isLoading = true},
                               label: {
                            ButtonView(text: "Update")
                        }).padding()
                    }.padding(.horizontal)
                    
                    
                    
                )
        }.overlay(
        
            VStack{
                if(isLoading){
                    LoadingIndicatorView()
                }

            }
        )
    }
    
}

struct EditSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        EditSelectionView(formField1: "Reset Token", formField2: "Password", formField3: "Confirm Password", formText1: Binding.constant(""), formText2: Binding.constant(""), formText3: Binding.constant(""), isSecret: true )
    }
}

