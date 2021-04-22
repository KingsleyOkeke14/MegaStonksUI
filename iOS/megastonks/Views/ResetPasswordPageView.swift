//
//  ResetPasswordPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-14.
//

import SwiftUI

struct ResetPasswordPageView: View {
    
    let myColors = MyColors()
    
    @State var formText1:String = ""
    @State var formText2:String = ""
    @State var formText3:String = ""
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack{
        EditSelectionView(formField1: "Reset Token", formField2: "New Password", formField3: "Confirm password", formText1: $formText1, formText2: $formText2, formText3: $formText3, isSecret: true)
            
        }
        .navigationBarHidden(true)
        
    }
}

struct ResetPasswordPageView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordPageView()
    }
}
