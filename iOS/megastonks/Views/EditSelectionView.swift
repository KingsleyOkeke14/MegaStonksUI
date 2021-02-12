//
//  EditSelectionView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-11.
//

import SwiftUI

struct EditSelectionView: View {
    var formField:String
    @Binding var formText:String
    var isSecret:Bool
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                VStack{
                    if(isSecret){
                        SecretFormView(formField: formField, secretText: $formText)
                        SecretFormView(formField: "Confirm " + formField, secretText: $formText)
                    }
                    else{
                        FormView(formField: formField, formText: $formText)
                    }
                
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        ButtonView(text: "Update")
                    }).padding()
                }.padding(.horizontal)
            
            
            
            )
    }
}

struct EditSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        EditSelectionView(formField: "Password", formText: Binding.constant(""), isSecret: true )
    }
}

