//
//  SearchBarView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-02-02.
//

import SwiftUI

struct SearchBarView: View {
    let myColors = MyColors()
    @Binding var text:String
    var body: some View {
        HStack{
            TextField("Search Stock Ticker Symbol", text: $text)
                .padding()
                .padding(.horizontal, 24)
                .background(myColors.grayColor)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .cornerRadius(20)

                
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(myColors.lightGrayColor)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 12)
                    }
                
                )
        
        }.padding()
    }
}


struct SearchBarView2: View {
    let myColors = MyColors()
    
    @State private var showingSheet = false
    @State private var searchText = ""
    
    var body: some View {
        VStack{
        Button(action: {
            showingSheet.toggle()
            
        }, label: {
            HStack{
                Text("Search Stock Ticker Symbol")
                    .padding()
                    .padding(.horizontal, 34)
                    .background(myColors.grayColor)
                    .foregroundColor(myColors.lightGrayColor)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .cornerRadius(20)

                    
                    .overlay(
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(MyColors().lightGrayColor)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 12)
                        }
                    
                    )
            
            }
        }).sheet(isPresented: $showingSheet) {
            SearchView(text: $searchText).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
          }
        }
    }
}


struct SearchView: View {
    
    let myColors = MyColors()
    @Binding var text: String
 
    @State var isEditing = false

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
                    HStack {
                        
                        TextField("Tap to Start Search", text: $text)
                            .padding()
                            .padding(.horizontal, 24)
                            .background(myColors.grayColor)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .cornerRadius(20)

                            
                            .overlay(
                                HStack{
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(myColors.lightGrayColor)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 12)
                                }
                            
                            )
                            .onTapGesture {
                                self.isEditing = true
                            }
             
                        if isEditing {
                            Button(action: {
                                self.isEditing = false
                                self.text = ""
                                hideKeyboard()
                                presentationMode.wrappedValue.dismiss()
             
                            }) {
                                Text("Cancel")
                                    .foregroundColor(myColors.greenColor)
                                .font(.custom("Apple SD Gothic Neo", fixedSize: 18))
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                            .animation(.default)
                        }
                    }.padding(.horizontal)

    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        //SearchBarView(text: Binding.constant(""))
        SearchView(text: Binding.constant(""))
            .preferredColorScheme(.dark)
        
//        SearchView(text: Binding.constant(""))
//            .preferredColorScheme(.dark)
    }
}
