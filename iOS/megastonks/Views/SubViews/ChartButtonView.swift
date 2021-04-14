//
//  ChartButtonView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-08.
//

import SwiftUI

struct ChartButtonView: View {
    


    @State var buttonList: [(buttonName: String, buttonState: Bool)] = [(buttonName: String, buttonState: Bool)]()
    


    
     func changeActiveButton(activeButton: Int){
        
        for index in 0..<buttonList.count{
            buttonList[index].buttonState = false
        }
        buttonList[activeButton].buttonState = true
        
        
    }
    var body: some View {
        HStack{
                    
                    Button(action: {
                        changeActiveButton(activeButton: 0)
                        
                    }, label: {
                        ButtonSelected(buttonName: buttonList[0].buttonName, buttonSelected: buttonList[0].buttonState)
                    })
                    Button(action: {
                        changeActiveButton(activeButton: 1)
                    }, label: {
                        ButtonSelected(buttonName: buttonList[1].buttonName, buttonSelected: buttonList[1].buttonState)
                    })
                 
                    Button(action: {
                        changeActiveButton(activeButton: 2)
                        
                    }, label: {
                        ButtonSelected(buttonName: buttonList[2].buttonName, buttonSelected: buttonList[2].buttonState)
                    })
                   
                    Button(action: {
                        changeActiveButton(activeButton: 3)
                        
                    }, label: {
                        ButtonSelected(buttonName: buttonList[3].buttonName, buttonSelected: buttonList[3].buttonState)
                    })
                    
                    Button(action: {
                        changeActiveButton(activeButton: 4)
                        
                    }, label: {
                        ButtonSelected(buttonName: buttonList[4].buttonName, buttonSelected: buttonList[4].buttonState)
                    })
             
                    Button(action: {
                        
                        changeActiveButton(activeButton: 5)
                        
                    }, label: {
                        ButtonSelected(buttonName: buttonList[5].buttonName, buttonSelected: buttonList[5].buttonState)
                    })
           
                    
        }
        
    }
}


struct ButtonSelected: View {
    var buttonName:String
    var buttonSelected:Bool
    
    let myColors = MyColors()
    var body: some View{
        ZStack{
            if(buttonSelected){
                Ellipse()
                    .fill(Color.green)
                    .frame(width: 44, height: 18)
                Text(buttonName)
                    .foregroundColor(.black)
                    .font(.custom("Verdana", fixedSize: 12))
                    .bold()
                    .padding(.horizontal, 8)
            }
            else{
                Ellipse()
                    .fill(Color.black)
                    .frame(width: 44, height: 18)
                Text(buttonName)
                    .foregroundColor(.white)
                    .font(.custom("Verdana", fixedSize: 12))
                    .bold()
                    .padding(.horizontal, 8)
            }

        }.padding(.horizontal, 6)

    }
    
}
struct ChartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let mYbuttonList = [("1D", true), ("5D", false), ("1M", false), ("3M", false), ("1Y", false), ("5Y", false)]
        ChartButtonView(buttonList: mYbuttonList)
    }
}

