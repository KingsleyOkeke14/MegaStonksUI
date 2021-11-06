//
//  ChatMessage.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-09-02.
//

import Foundation

struct ChatMessage : Identifiable, Hashable {
    var id: UUID = UUID()
    var message: String
    var isReply: Bool
    var timeStamp: String
}

struct ChatUser : Identifiable, Hashable {
    let id: Int
    let userName, image: String
    let connectionId: String?
    let isConsultant: Bool
    let lastUpdated: String
}

struct ChatFeed : Identifiable, Hashable {
    var id : UUID = UUID()
    var user : ChatUser
    var sessionId : Int?
    var chatMessages: [ChatMessage]?
    
    init(chatFeedElementResponse resp : ChatFeedElementResponse){
        self.user = ChatUser(id: resp.user.id, userName: resp.user.userName, image: resp.user.image, connectionId: resp.user.connectionId, isConsultant: resp.user.isConsultant, lastUpdated: resp.user.lastUpdated)
        
        self.sessionId = resp.chatSession?.id
        
        if let messages = resp.messages {
            self.chatMessages = [ChatMessage]()
            messages.forEach { message in
                self.chatMessages?.append(ChatMessage(message: message.message, isReply: message.isReply, timeStamp: message.timeStamp.getTimeInterval()))
            }
        }
    }
}

extension ChatUser {
    func toChatUserResponse() -> ChatUserResponse {
        return ChatUserResponse(id: self.id, userName: self.userName, image: self.image, connectionId: self.connectionId, isConsultant: self.isConsultant, lastUpdated: self.lastUpdated)
    }
}
