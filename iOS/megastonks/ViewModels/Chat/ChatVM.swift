//
//  ChatVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-09-02.
//

import Foundation

class ChatVM : ObservableObject {
    
    
    
    let chatAPI = ChatApi.shared
    
    @Published var messages: [ChatMessage]
    
    init() {
        messages = [ChatMessage]()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessages(_:)), name: .newMessageReceived, object: nil)
    }
    
    func sendMessage(user: String, message: String) {
        messages.append(ChatMessage(message: message, isReply: false))
        chatAPI.sendMessage(user: user, message: message)
    }
    

    
    @objc func updateMessages(_ notification: Notification){
        if let message = notification.userInfo as? [String: String]{
            messages.append(ChatMessage(message: message["message"]!, isReply: true))
        }
    }
}
