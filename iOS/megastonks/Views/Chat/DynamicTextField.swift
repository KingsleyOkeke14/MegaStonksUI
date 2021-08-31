//
//  DynamicTextField.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-08-29.
//

import SwiftUI

struct DynamicTextField : UIViewRepresentable {
    
    
    @Binding var text: String
    @Binding var height: CGFloat
    
    func makeCoordinator() -> Coordinator {
        return DynamicTextField.Coordinator(parent: self)
    }
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.isScrollEnabled = true
        view.text = "Enter Message"
        view.font = .systemFont(ofSize: 18)
        view.textColor = .white
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        
        return view
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
        }
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        var parent : DynamicTextField
        
        init(parent: DynamicTextField) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if(self.parent.text == ""){
                textView.text = ""
                textView.textColor = .white
            }
        }
        func textViewDidEndEditing(_ textView: UITextView) {
            if(self.parent.text == ""){
                textView.text = "Enter Message"
                textView.textColor = .white
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.text = textView.text
            }
        }
    }
}
