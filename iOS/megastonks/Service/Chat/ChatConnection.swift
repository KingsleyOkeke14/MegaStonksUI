//
//  ChatApi.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-09-02.
//

import Foundation
import SignalRClient

class ChatConnection {
    
    static let shared = ChatConnection()
    
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
    
    func startChat(){
        
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

class ChatAPI{
    static let shared = ChatAPI()
    private let chatURL: URL
    let decoder = JSONDecoder()
    init(){
        chatURL = URL(string: APIRoutes().server + "chat/")!
    }
    
    func CreateUser(userName: String, userImage: String, completion: @escaping (Result<ChatUser, Error>) -> ()) {
        
        let queryItems = [URLQueryItem(name: "userName", value: "\(userName)"),
                          URLQueryItem(name: "userImage", value: "\(userImage)")]
        let rquestURL = chatURL.appending(queryItems)!
        let request = AppUrlRequest(url: rquestURL, httpMethod: "PUT").request

        
        
        let task = API().session.dataTask(with: request) { [unowned self] (data, response, error) in
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : "Error contacting the server. Please Check your internet connection"])))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode == 200{
                    if let data = data {
                        if let chatUser = try? self.decoder.decode(ChatUser.self, from: data){
                            completion(.success(chatUser))
                            return
                        }
                        else{
                            completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey :  "Could not parse user object"])))
                            return
                        }
                    }
                }
                else{
                    
                    if let error = try? self.decoder.decode(CommonAPIResponse.self, from: data!){
                        completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey :  "\(error.message)"])))
                        return
                    }
                    else{
                        completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey :  "Please try again with a different username or contact support"])))
                    }
              
                    return
                    
                }
            }
            
        }
        task.resume()
    }
}
