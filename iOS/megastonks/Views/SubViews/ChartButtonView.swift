//
//  ChartButtonView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-08.
//

import SwiftUI

struct ChartButtonView: View {
    



    
    
    @State var buttonColor = Color.green

    

    var body: some View {
        HStack(spacing: 12){
                    
                    Button(action: {
                        changeActiveButton(activeButton: 0)
                        
                    }, label: {
                        ButtonSelected(buttonName: buttonList[0].buttonName, buttonSelected: buttonList[0].buttonState, buttonColor: $buttonColor)
                    })
                    Button(action: {
                        changeActiveButton(activeButton: 1)
                    }, label: {
                        ButtonSelected(buttonName: buttonList[1].buttonName, buttonSelected: buttonList[1].buttonState, buttonColor: $buttonColor)
                    })
                 
                    Button(action: {
                        changeActiveButton(activeButton: 2)
                        
                    }, label: {
                        ButtonSelected(buttonName: buttonList[2].buttonName, buttonSelected: buttonList[2].buttonState, buttonColor: $buttonColor)
                    })
                   
                    Button(action: {
                        changeActiveButton(activeButton: 3)
                        
                    }, label: {
                        ButtonSelected(buttonName: buttonList[3].buttonName, buttonSelected: buttonList[3].buttonState, buttonColor: $buttonColor)
                    })
                    
                    Button(action: {
                        changeActiveButton(activeButton: 4)
                        
                    }, label: {
                        ButtonSelected(buttonName: buttonList[4].buttonName, buttonSelected: buttonList[4].buttonState, buttonColor: $buttonColor)
                    })
             
                    Button(action: {
                        
                        changeActiveButton(activeButton: 5)
                        
                    }, label: {
                        ButtonSelected(buttonName: buttonList[5].buttonName, buttonSelected: buttonList[5].buttonState, buttonColor: $buttonColor)
                    })
           
                    
        }
        
    }
}



struct ChartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let mYbuttonList = [("1D", true), ("5D", false), ("1M", false), ("3M", false), ("1Y", false), ("5Y", false)]
        ChartButtonView(buttonList: mYbuttonList)
    }
}

