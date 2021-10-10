//
//  ChatVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-09-02.
//

import Foundation

class ChatVM : ObservableObject {
    
    
    
    let chatAPI = ChatConnection.shared
    
    @Published var messages: [ChatMessage]
    @Published var error: String
    
    init() {
        messages = [ChatMessage]()
        error = ""
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessages(_:)), name: .newMessageReceived, object: nil)
    }
    
    func sendMessage(user: String, message: String) {
        messages.append(ChatMessage(message: message, isReply: false, timeStamp: ""))
        chatAPI.sendMessage(user: user, message: message)
    }
    

    
    @objc func updateMessages(_ notification: Notification){
        if let message = notification.userInfo as? [String: String]{
            messages.append(ChatMessage(message: message["message"]!, isReply: true, timeStamp: ""))
        }
    }

}
