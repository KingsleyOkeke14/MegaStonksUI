//
//  ChatRegisterView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-08-23.
//

import SwiftUI

struct ChatRegisterView: View {
    
    let myColors = MyColors()
    @State private var displayName: String = ""
    @State private var password: String = ""

//    @State private var timer = Timer.scheduledTimer(timeInterval: 10, invocation: , repeats: false)
    @State private var showImagePicker = false
    @State private var showImagePickerHint: Bool = true
    
    @State var imageOptions: [ProfileImageOption] = ProfileImageOptions().options
    
    @EnvironmentObject var userAuth: UserAuth
    @Environment(\.presentationMode) var presentationMode
 
    var body: some View {
        VStack{
            Spacer()
            
            Button(action: {
                showImagePickerHint = false
                showImagePicker.toggle()
                
            }, label: {
                ZStack {
                    Circle()
                        .stroke(myColors.greenColor, lineWidth: 4)
                        .frame(width: 100, height: 100)
                    
                    Text(imageOptions.first(where: { $0.isSelected })?.image ?? "")
                        .font(.custom("", fixedSize: 70))
                        .offset(y: 3)
                        .opacity(showImagePickerHint ? 0.2 : 1.0)
                    
                    if(showImagePickerHint){
                        Image(systemName: "plus.circle")
                            .foregroundColor(myColors.greenColor)
                    }
                    }
            })
        
            
            FormView(formField: "Display Name", formText: $displayName)
            
            
            HStack {
                Spacer()
                Image(systemName: "questionmark.circle")
                    .foregroundColor(myColors.greenColor)
                    .font(.title2)
                    .padding()
            }
            
            HStack {
                Spacer()
                Text("Proceed To Chat")
                    .foregroundColor(myColors.greenColor)
                    .bold()
                Image(systemName: "arrow.right.circle.fill")
                    .foregroundColor(myColors.greenColor)
                    .font(.title2)
                    .padding(.trailing)
            }
            
            Spacer()
            Button(action: {
                userAuth.isInChatMode = false
            }, label: {
                HStack {
                    
                    Image(systemName: "arrow.backward.circle.fill")
                        .foregroundColor(myColors.redColor)
                        .font(.title2)
                        
                    Text("Exit To Main App")
                        .foregroundColor(myColors.redColor)
                        .bold()
                        .padding(.trailing)

                }
            })
            
            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            ProfileImagePickerView(imageOptions: $imageOptions).preferredColorScheme(.dark)
        }
    }
}

struct ChatRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRegisterView().preferredColorScheme(.dark)
    }
}
