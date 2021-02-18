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
    @State var activeSelction:String = ""
    
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
                        changeActiveButton(activeButton: 0)
                        activeSelction = buttonList[0].buttonName
                        
                        
                    }, label: {
                        SelectButton(buttonText: buttonList[0].buttonName, buttonSelected: $buttonList[0].buttonState)
                    })
                    Spacer()
                    Button(action: {
                        
                        changeActiveButton(activeButton: 1)
                        activeSelction = buttonList[1].buttonName
                        
                    },
                    label: {
                        SelectButton(buttonText: buttonList[1].buttonName, buttonSelected: $buttonList[1].buttonState)
                    })
                    Spacer()
                }
    
        
    }
}


struct SelectButton: View {
    let myColors = MyColors()
    var buttonText:String = ""
    @Binding var buttonSelected:Bool
    
    var body: some View {
        HStack{
            if(buttonSelected){
                Text(buttonText)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(myColors.greenColor)
                    .cornerRadius(12)
            }
            else{
                Text(buttonText)
                    .foregroundColor(myColors.greenColor)
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
        ButtonSelectionView()
        
    }
}
