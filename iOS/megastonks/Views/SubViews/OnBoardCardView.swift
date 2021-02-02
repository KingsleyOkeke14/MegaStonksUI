//
//  OnBoardView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-01.
//

import SwiftUI

struct OnBoardCardView: View {
    
    var greenColor:Color = Color.init(red: 72/255, green: 175/255, blue: 56/255)
    
    
    var card:OnBoardCard
    var showButton:Bool = false
    var body: some View {
        VStack{
            Spacer()
            Image(systemName: card.image)
                .font(.system(size: 180))
                .foregroundColor(greenColor)
            Spacer()
            Text(card.title)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            Text(card.description)
                .multilineTextAlignment(.center)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding()
            Spacer()
            if(showButton){
                HStack{
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        ButtonView(text: "Next", strokeLineWidth: 2, frameWidth: 100, frameHeight: 36)
                    })
                }.padding(.trailing, 20)
                Spacer()
            }
        }
    }
}

struct OnBoardCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardCardView(card: OnBoardCardModel().cards[0], showButton: true)
            .preferredColorScheme(.dark)
    }
}
