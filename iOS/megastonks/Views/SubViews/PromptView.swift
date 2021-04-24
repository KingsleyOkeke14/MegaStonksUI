//
//  PromptView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-04-23.
//

import SwiftUI

struct PromptView: View {
    
    @Binding var promptText:String
    @Binding var isError:Bool
    
    var body: some View {
        if(isError){
            Text(promptText)
                .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                .foregroundColor(.red)
                .bold()
                .padding(.horizontal, 10)
                .multilineTextAlignment(.center)
            
            
        }
        else{
            Text(promptText)
                .font(.custom("Apple SD Gothic Neo", fixedSize: 14))
                .foregroundColor(.white)
                .bold()
                .padding(.horizontal, 10)
                .multilineTextAlignment(.center)
        }
        
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView(promptText: Binding.constant("Tester"), isError: Binding.constant(true))
    }
}
