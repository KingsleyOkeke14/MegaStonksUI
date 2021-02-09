//
//  StockInfoView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-04.
//

import SwiftUI

struct StockInfoView: View {
    
    let grayColor:Color = Color.init(red: 22/255, green: 21/255, blue: 21/255)
    
    var greenColor:Color = Color.init(red: 72/255, green: 175/255, blue: 56/255)
    
    
    var body: some View {
                HStack{
                    VStack{


                        ZStack{
                            Circle()
                                .stroke(greenColor, lineWidth: 4)
                                .frame(width: 110, height: 110)
                                .shadow(color: greenColor, radius: 6, x: 4, y: 4)
                            Circle()
                                .fill(grayColor)
                                .frame(width: 110, height: 110)
                            Text("DOC")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .scaledToFill()
                                .padding()
                        }.padding()
                        
                        Text("CloudMD Software & Services Inc ")
                            .font(.custom("Helvetica", size: 20))
                            .foregroundColor(.white)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.top, 20)
                        
                        HStack {
                            Text("$247.20")
                                .foregroundColor(.white)
                                .font(.custom("Verdana", size: 40))
                                .bold()
                                  +
                                    Text(" CAD")
                                    .foregroundColor(.white)
                                    .font(.custom("Verdana", size: 20))
                                .bold()
                                .baselineOffset(0)
                                
                        }.padding()
                        HStack{
                            Text("+22.33 (+10.12%)")
                                .foregroundColor(greenColor)
                                .font(.title3)
                                .bold()
                                
                            Text("Today")
                                .foregroundColor(.white)
                                .bold()
                                
                        }
                    
                         

                        
                    }
                }
    }
}


struct StockInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StockInfoView()
    }
}
