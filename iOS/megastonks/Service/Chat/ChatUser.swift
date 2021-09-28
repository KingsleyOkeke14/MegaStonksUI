//
//  ChatUser.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-09-27.
//

import Foundation

struct ChatUser : Codable{
    let id: Int
    let userName, image: String
    let connectionId : String?
    let isConsultant: Bool
    let lastUpdated: String
}

struct ChatUserProfileCache {
    static let key = "ChatUser"
    static func save(_ value: ChatUser!) {
         UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    static func get() -> ChatUser! {
        var userData: ChatUser!
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode(ChatUser.self, from: data)
            return userData!
        } else {
            return userData
        }
    }
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
