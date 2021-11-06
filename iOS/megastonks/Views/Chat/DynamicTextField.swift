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
    
    var placeholder = "Enter Message"
    
    @State var isEditing: Bool = false
    
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
    func updateUIView(_ textView: UITextView, context: Context) {
        
        if self.text == "" {
            textView.text = self.isEditing ? "" : self.placeholder
            textView.textColor = self.isEditing ? .label : .lightGray
        }
        
        
        DispatchQueue.main.async {
            self.height = textView.contentSize.height
        }
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        var parent : DynamicTextField
        
        init(parent: DynamicTextField) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.isEditing = true
            }
        }
        func textViewDidEndEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.isEditing = false
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
