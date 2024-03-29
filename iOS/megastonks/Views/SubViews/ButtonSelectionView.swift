//
//  ButtonSelectionView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-16.
//

import SwiftUI

struct ButtonSelectionView: View {
    let myColors = MyColors()
    
    @State var buttonList: [(buttonName: String, buttonState: Bool)] = [("CAD", true), ("USD", false)]
    @Binding var activeSelction:String
    @State var buttonColor:Color
    
    func changeActiveButton(activeButton: Int){
        
        for index in 0..<buttonList.count{
            buttonList[index].buttonState = false
        }
        buttonList[activeButton].buttonState = true
        
        
    }
    
    var body: some View {
                HStack {
                    Spacer()
                    Button(action: {
                        hideKeyboard()
                        changeActiveButton(activeButton: 0)
                        activeSelction = buttonList[0].buttonName
                        
                        
                    }, label: {
                        SelectButton(buttonText: buttonList[0].buttonName, buttonSelected: $buttonList[0].buttonState, buttonColor: $buttonColor)
                    })
                    Spacer()
                    Button(action: {
                        hideKeyboard()
                        changeActiveButton(activeButton: 1)
                        activeSelction = buttonList[1].buttonName
                        
                    },
                    label: {
                        SelectButton(buttonText: buttonList[1].buttonName, buttonSelected: $buttonList[1].buttonState, buttonColor: $buttonColor)
                    })
                    Spacer()
                }
    
        
    }
}


struct SelectButton: View {
    let myColors = MyColors()
    var buttonText:String = ""
    @Binding var buttonSelected:Bool
    @Binding var buttonColor:Color
    
    var body: some View {
        HStack{
            if(buttonSelected){
                Text(buttonText)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(buttonColor)
                    .cornerRadius(12)
            }
            else{
                Text(buttonText)
                    .foregroundColor(buttonColor)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(myColors.grayColor)
                    .cornerRadius(12)
                
            }
            
        }
        
    }
}

struct ButtonSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonSelectionView(activeSelction: Binding.constant(""), buttonColor: Color.green)
        
    }
}
