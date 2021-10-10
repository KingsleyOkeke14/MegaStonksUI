//
//  ChatApiModel.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-10-09.
//

import Foundation

// MARK: - ChatFeedElement
struct ChatFeedElementResponse: Codable {
    let user: ChatUserResponse
    let chatSession: ChatSessionResponse?
    let messages: [MessageResponse]?
}

// MARK: - ChatSession
struct ChatSessionResponse: Codable {
    let id: Int
    let user1, user2: ChatUserResponse?
    let createdAt: String?
}

// MARK: - User
struct ChatUserResponse: Codable {
    let id: Int
    let userName, image: String
    let connectionId: String?
    let isConsultant: Bool
    let lastUpdated: String
}

// MARK: - Message
struct MessageResponse: Codable {
    let id : Int
    let message: String
    let isReply, isRead: Bool
    let timeStamp: String
}

typealias ChatFeedResponse = [ChatFeedElementResponse]
