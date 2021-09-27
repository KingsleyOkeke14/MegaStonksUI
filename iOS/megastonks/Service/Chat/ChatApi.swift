//
//  ChatApi.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-09-02.
//

import Foundation
import SignalRClient

class ChatApi {
    
    static let shared = ChatApi()
    
    var hubConnection: HubConnection
    let nc = NotificationCenter.default
    
    init() {
        hubConnection = HubConnectionBuilder(url: URL(string: "https://megastonksdev.azurewebsites.net/chatHub")!)
            .withLogging(minLogLevel: .debug)
            .build()
        
        //Register Event
        hubConnection.on(method: "ReceiveMessage") {(user: String, message: String) in
            
            self.nc.post(name: .newMessageReceived, object: nil, userInfo: ["message" : message])
            print(">>> \(user): \(message)")
        }
        
        //Start Connection
        hubConnection.start()
    }
    
    func sendMessage(user: String, message: String) {
        hubConnection.invoke(method: "SendMessage", user, message, resultType: String.self) { result, error in
            if let error = error {
                print("error: \(error)")
            } else {
                print("Add result: \(result!)")
            }
        }
    }
    

    
    
    
    func stopConnection() {
        hubConnection.stop()
    }
}
