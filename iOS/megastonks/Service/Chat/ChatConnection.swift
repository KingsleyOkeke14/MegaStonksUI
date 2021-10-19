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
    func sendMessage(user: ChatUser, sessionId: Int, message: String) {
        let postMessageRequest = PostChatMessageRequest(sender: ChatUserResponse(id: user.id, userName: user.userName, image: user.image, connectionId: user.connectionId, isConsultant: user.isConsultant, lastUpdated: user.lastUpdated),
                                                        sessionId: sessionId,
                                                        message: message)
        hubConnection.invoke(method: "SendMessage",
                             postMessageRequest,
                             resultType: String.self)
        { result, error in
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
    private let createUserURL: URL = URL(string: APIRoutes().server + "chat/createUser")!
    private let getFeedURL: URL = URL(string: APIRoutes().server + "chat/getFeed")!
    private let startChatURL: URL = URL(string: APIRoutes().server + "chat/startChat")!
    private let saveMessageURL: URL = URL(string: APIRoutes().server + "chat/saveMessage")!
    private let startChatUrl: URL = URL(string: APIRoutes().server + "chat/startChat")!
    
    let decoder = JSONDecoder()
    
    func createUser(userName: String, userImage: String, completion: @escaping (Result<ChatUserResponse, Error>) -> ()) {
        
        let queryItems = [URLQueryItem(name: "userName", value: "\(userName)"),
                          URLQueryItem(name: "userImage", value: "\(userImage)")]
        let requestURL = createUserURL.appending(queryItems)!
        let request = AppUrlRequest(url: requestURL, httpMethod: "PUT").request

        
        
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
                        if let chatUser = try? self.decoder.decode(ChatUserResponse.self, from: data){
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
    
    func fetchFeed(user: ChatUserResponse, completion: @escaping (Result<ChatFeedResponse, Error>) -> ()){
        let url = getFeedURL.appending([URLQueryItem(name: "userId", value: String(user.id))])!
        let request = AppUrlRequest(url: url, httpMethod: "GET").request
        
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
                        if let chatFeed = try? self.decoder.decode(ChatFeedResponse.self, from: data){
                            completion(.success(chatFeed))
                            return
                        }
                        else{
                            completion(.failure(NSError(domain: "", code: 2, userInfo: [NSLocalizedDescriptionKey :  "Could not parse chat feed object"])))
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
                        completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey :  "Please try again or contact support @ hello@megastonks.com"])))
                    }
              
                    return
                    
                }
            }
            
        }
        task.resume()
    }
    
    
    func startChat(user: ChatUserResponse, userToStartChatWith: ChatUserResponse, completion: @escaping (Result<ChatSessionResponse, Error>) -> ()){
        let url = startChatUrl
        let request = AppUrlRequest(url: url, httpMethod: "POST").request
        let jsonData = try! JSONEncoder().encode(StartChatRequest(user: user, userToStartChatWith: userToStartChatWith))
        
        let task = API().session.uploadTask(with: request, from: jsonData ) { [unowned self] (data, response, error) in
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : "Error contacting the server. Please Check your internet connection"])))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode == 200{
                    if let data = data {
                        if let chatSession = try? self.decoder.decode(ChatSessionResponse.self, from: data){
                            completion(.success(chatSession))
                            return
                        }
                        else{
                            completion(.failure(NSError(domain: "", code: 2, userInfo: [NSLocalizedDescriptionKey :  "Could not parse chat Session object"])))
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
                        completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey :  "Could not start Chat Session. Please try again or contact support @ hello@megastonks.com"])))
                    }
              
                    return
                    
                }
            }
            
        }
        task.resume()
    }
}
