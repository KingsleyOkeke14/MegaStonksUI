//
//  FormSecretView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-01-31.
//

import SwiftUI

struct SecretFormView: View {
    
    
    
    var formField:String
    
    @Binding var secretText:String
    
    
    var body: some View {
        VStack(spacing: 0.5){
            HStack{
                Text(formField)
                    .foregroundColor(MyColors().greenColor)
                    .font(.custom("Apple SD Gothic Neo", fixedSize: 20))
                    .bold()
                Spacer()
            }
            SecureField("", text: $secretText)
                .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                .foregroundColor(.white)
                
            Rectangle()
                .fill(MyColors().greenColor)
                 .frame(height: 2)
                 .edgesIgnoringSafeArea(.horizontal)
            
    
        }.padding()
        .lineLimit(1)
        .minimumScaleFactor(0.8)
    }
}

struct SecretFormView_Previews: PreviewProvider {
    static var previews: some View {
        SecretFormView(formField: "Password", secretText: Binding.constant(""))
    }
}
