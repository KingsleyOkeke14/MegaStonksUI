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
}
