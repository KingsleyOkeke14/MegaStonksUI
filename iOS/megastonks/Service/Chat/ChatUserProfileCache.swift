//
//  ChatUser.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-09-27.
//

import Foundation

struct ChatUserProfileCache {
    static let key = "ChatUser"
    static func save(_ value: ChatUserResponse!) {
         UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    static func get() -> ChatUserResponse! {
        var userData: ChatUserResponse!
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode(ChatUserResponse.self, from: data)
            return userData!
        } else {
            return userData
        }
    }
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
