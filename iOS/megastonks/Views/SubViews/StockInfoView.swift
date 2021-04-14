//
//  StockInfoView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-04.
//

import SwiftUI

struct StockInfoView: View {
    
    let mycolors = MyColors()
    
    
    var body: some View {
//        Color.black
//            .ignoresSafeArea()
//            .overlay(
            
            
                HStack{
                    VStack{


                        ZStack{
                            Circle()
                                .stroke(Color.green, lineWidth: 4)
                                .frame(width: 110, height: 110)
                                .shadow(color: Color.green, radius: 6, x: 4, y: 4)
                            Circle()
                                .fill(mycolors.grayColor)
                                .frame(width: 110, height: 110)
                            Text("DOC")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding()
                        }
                        
                        Text("CloudMD Software & Services Inc ")
                            .font(.custom("Helvetica", fixedSize: 20))
                            .foregroundColor(.white)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            
                        
                        HStack {
                            Text("$247.20")
                                .foregroundColor(.white)
                                .font(.custom("Verdana", fixedSize: 40))
                                .bold()
                                  +
                                    Text(" CAD")
                                    .foregroundColor(.white)
                                    .font(.custom("Verdana", fixedSize: 20))
                                .bold()
                                .baselineOffset(0)
                                
                        }
                        
                    }
                }
//            )
    }
}


struct StockInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StockInfoView()
    }
}
