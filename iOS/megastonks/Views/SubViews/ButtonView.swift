//
//  ButtonView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-01.
//

import SwiftUI

struct ButtonView: View {
    
    
    
    let myColors = MyColors()
    var cornerRadius:CGFloat = 12
    var strokeColor:Color = MyColors().buttonStrokeGreenColor
    var text:String = ""
    var textColor:Color = Color.init(red: 72/255, green: 175/255, blue: 56/255)
    var textSize:CGFloat = 30
    var strokeLineWidth:CGFloat = 4
    var frameWidth:CGFloat = 140
    var frameHeight:CGFloat = 48
    var backGroundColor:Color = MyColors().grayColor
    
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(strokeColor, lineWidth: strokeLineWidth)
                .frame(width: frameWidth, height: frameHeight)
                .background(backGroundColor)
            
            Text(text)
                .foregroundColor(textColor)
                .font(.custom("Apple SD Gothic Neo", size: textSize))
                .fontWeight(.heavy)
                .padding(.top, 5)
                
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
            .preferredColorScheme(.dark)
    }
}
