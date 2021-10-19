//
//  ChatVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-09-02.
//

import Foundation

class ChatVM : ObservableObject {
    
    let chatConnection = ChatConnection.shared
    let chatApi = ChatAPI.shared
    
    @Published var feed: [ChatFeed]
    @Published var error: String
    
    init() {
        feed = [ChatFeed]()
        error = ""
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessages(_:)), name: .newMessageReceived, object: nil)
    }
    
    
    
    func sendMessage(user: ChatUser, sessionId: Int, message: String) {
        let feedToUpdate = feed.firstIndex(where: { $0.sessionId == sessionId })
        if let feedToUpdate = feedToUpdate {
            feed[feedToUpdate].chatMessages?.append(ChatMessage(message: message, isReply: false, timeStamp: String(describing: Date())))
        }
        chatConnection.sendMessage(user: user, sessionId: sessionId, message: message)
    }


    
    func updateFeed(user: ChatUserResponse){
         chatApi.fetchFeed(user: user){ result in
            switch result {
                
            case .success(let feedResponse):
                var feedToAppend = [ChatFeed]()
                
                feedResponse.forEach({ resp in
                    feedToAppend.append(ChatFeed(chatFeedElementResponse: resp))
                })
                self.feed = feedToAppend
            case .failure(_):
                print("Error")
            }
        }
    }
    
    @objc func updateMessages(_ notification: Notification){
        if let incomingMessage = notification.userInfo as? [String: PostChatMessageResponse]{
            let message = incomingMessage["message"]
            let feedToUpdate = feed.firstIndex(where: { $0.sessionId == message?.chatSessionId })
            
            if let feedToUpdate = feedToUpdate {
                feed[feedToUpdate].chatMessages?.append(ChatMessage(message: message?.message ?? "", isReply: true, timeStamp: String(describing: Date())))
            }
        }
    }
}
