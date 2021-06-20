//
//  NumberPadView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-01.
//

import Foundation
import SwiftUI

struct NumberPadView : View {
    
    @Binding var codes : [String]
    var isCrypto:Bool
    
    var body : some View{
        
        VStack(alignment: .leading,spacing: 20){
            
            
            ForEach(isCrypto ? datasCrypto : datasStock){i in
                
                HStack(spacing: self.getspacing()){
                    
                    ForEach(i.row){j in
                        
                        Button(action: {
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                impactMed.impactOccurred()
                            if (j.value == "delete.left.fill"){
                                if(!codes.isEmpty){
                                    self.codes.removeLast()
                                }    
                            }
                            else{
                                self.codes.append(j.value.removingWhitespaces())
                            }
                            
                        }) {
                            
                            if j.value == "delete.left.fill"{
                                
                                Image(systemName: j.value)
                                    .font(.custom("Verdana", fixedSize: 18))
                                    .padding(.vertical)
                            }
                            else{
                                
                                Text(j.value)
                                    .foregroundColor(.white)
                                    .font(.custom("Verdana", fixedSize: 24))
                                    .bold().padding(.vertical)
                                    .shadow(color: .white, radius: 12, x: 2, y: 4)
                                 
                                  
                            }
                            
                            
                        }
                    }
                }
                
            }
            
        }.foregroundColor(.white)
    }
    
    func getspacing()->CGFloat{
        
        return UIScreen.main.bounds.width / 3
    }
    
    func getCode()->String{
        
        var code = ""
        
        for i in self.codes{
        
            code += i
            
        }

        return code.replacingOccurrences(of: " ", with: "")
    }
}
struct NumberPadView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadView(codes: Binding.constant(["", ""]), isCrypto: true).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
// datas...

struct type : Identifiable {
    
    var id : Int
    var row : [row]
}

struct row : Identifiable {
    
    var id : Int
    var value : String
}

var datasStock = [

type(id: 0, row: [row(id: 0, value: "1"),row(id: 1, value: "2"),row(id: 2, value: "3")]),
type(id: 1, row: [row(id: 0, value: "4"),row(id: 1, value: "5"),row(id: 2, value: "6")]),
type(id: 2, row: [row(id: 0, value: "7"),row(id: 1, value: "8"),row(id: 2, value: "9")]),
type(id: 3, row: [row(id: 0, value: ""), row(id: 1, value: "  0"), row(id: 2, value: "delete.left.fill")])
]

var datasCrypto = [

type(id: 0, row: [row(id: 0, value: "1"),row(id: 1, value: "2"),row(id: 2, value: "3")]),
type(id: 1, row: [row(id: 0, value: "4"),row(id: 1, value: "5"),row(id: 2, value: "6")]),
type(id: 2, row: [row(id: 0, value: "7"),row(id: 1, value: "8"),row(id: 2, value: "9")]),
type(id: 3, row: [row(id: 0, value: " ."), row(id: 1, value: "0"), row(id: 2, value: "delete.left.fill")])
]

