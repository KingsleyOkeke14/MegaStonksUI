//
//  SearchBarView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-02.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text:String
    var body: some View {
        HStack{
            TextField("Search Stock Ticker Symbol", text: $text)
                .padding()
                .padding(.horizontal, 24)
                .background(MyColors().grayColor)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .cornerRadius(20)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(MyColors().lightGrayColor)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 12)
                    }
                
                )
        }.padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: Binding.constant(""))
            .preferredColorScheme(.dark)
        SearchBarView(text: Binding.constant(""))
    }
}
