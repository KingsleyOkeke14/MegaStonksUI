//
//  ProfileImagePickerView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-08-23.
//

import SwiftUI

let myColors = MyColors()
struct ProfileImagePickerView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    
    @Binding var imageOptions: [ProfileImageOption]
    
    
    
    @Environment(\.presentationMode) var presentationMode
    
    init(imageOptions: Binding<[ProfileImageOption]>) {
        self._imageOptions = imageOptions
    }
    
    var body: some View {
        Color.black.ignoresSafeArea()
            .overlay(
                VStack(alignment: .center){
                    VStack{
                        
                    }.frame(height: 40)
                    
                    ScrollView{
                        VStack{
                            
                        }.frame(height: 20)
                        LazyVGrid(columns: columns){
                            ForEach(0..<imageOptions.count) { i in
                                
                                
                                ProfileImageView(image: imageOptions[i].image, isSelected: $imageOptions[i].isSelected)
                                    .onTapGesture(perform: {
                                        imageOptions.indices.forEach { index in
                                            imageOptions[index].isSelected = false
                                        }
                                        imageOptions[i].isSelected = true
                                    })
                            }
                        }
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                              , label: {
                                ButtonView(cornerRadius: 12,  text: "Continue", textColor: myColors.grayColor, textSize: 20, frameWidth: 100, frameHeight: 34, backGroundColor: .green, strokeBorders: false, fillColor: .green).padding(.top, 40)
                        })

                    }.padding(.horizontal)  
                }
            )
    }
}

struct ProfileImageView: View {
    var image: String
    @Binding var isSelected: Bool
    var body: some View{
        VStack{
            Circle()
                .stroke(isSelected ? myColors.greenColor : myColors.greenColor.opacity(0.6), lineWidth: isSelected ? 4 : 2)
                .frame(width: 110, height: 110)
                
                .overlay(
                    Text(image)
                        .font(.custom("", fixedSize: 80))
                        .offset(y: 2)
                )
                .overlay(
                    VStack{
                        if(isSelected){
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(myColors.greenColor)
                                .offset(x: 44, y: -42)
                            
                        }
                    }
                )
        }
    }
}

struct ProfileImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImagePickerView(imageOptions: Binding.constant(ProfileImageOptions().options)).preferredColorScheme(.dark)
    }
}
