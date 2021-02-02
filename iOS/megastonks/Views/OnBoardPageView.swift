//
//  OnBoardPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-01.
//

import SwiftUI

struct OnBoardPageView: View {
    @State var selectedPage:Int = 0
    
    var cards:[OnBoardCard] = OnBoardCardModel().cards
    
    var body: some View {
        
        Color.black
            .ignoresSafeArea() // Ignore just for the color
            .overlay(
                VStack{
                    
                    
                    TabView(selection: $selectedPage){
                        ForEach(0..<OnBoardCardModel().cards.count){
                            index in
                            if(index != (OnBoardCardModel().cards.count - 1)){
                                OnBoardCardView(card: cards[index]).tag(index)
                            }
                            else{
                                OnBoardCardView(card: cards[index], showButton: true).tag(index)
                                
                            }
                            
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
                    
                }
            )
    }
}


struct OnBoardPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardPageView()
    }
}
