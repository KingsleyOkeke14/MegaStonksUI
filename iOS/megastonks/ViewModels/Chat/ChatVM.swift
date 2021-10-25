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
        self.feed = [ChatFeed]()
        self.error = ""
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessages(_:)), name: .newMessageReceived, object: nil)
    }
    
    
    
    func sendMessage(user: ChatUserResponse, sessionId: Int, message: String, completion: @escaping (Result<PostChatMessageResponse, Error>) -> ()) {
        chatConnection.sendMessage(user: user, sessionId: sessionId, message: message) { result in
            switch result {
                
            case .success(let response):
                DispatchQueue.main.async {
                    let feedToUpdate = self.feed.firstIndex(where: { $0.sessionId == sessionId })
                    if let feedToUpdate = feedToUpdate {
                        self.feed[feedToUpdate].chatMessages?.append(ChatMessage(message: response.message, isReply: response.isReply, timeStamp: response.timeStamp.getTimeInterval()))
                    }
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    
    func updateFeed(user: ChatUserResponse){
         chatApi.fetchFeed(user: user){ result in
            switch result {
                
            case .success(let feedResponse):
                var feedToAppend = [ChatFeed]()
                
                feedResponse.forEach({ resp in
                    feedToAppend.append(ChatFeed(chatFeedElementResponse: resp))
                })
                DispatchQueue.main.async {
                    self.feed = feedToAppend
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
    @objc func updateMessages(_ notification: Notification){
        if let incomingMessage = notification.userInfo as? [String: PostChatMessageResponse]{
            if let message = incomingMessage["message"] {
            let feedToUpdate = feed.firstIndex(where: { $0.sessionId == message.chatSessionId })
            
            if let feedToUpdate = feedToUpdate {
                feed[feedToUpdate].chatMessages?.append(ChatMessage(message: message.message, isReply: true, timeStamp: message.timeStamp.getTimeInterval()))
            }
         }
        }
    }
}
