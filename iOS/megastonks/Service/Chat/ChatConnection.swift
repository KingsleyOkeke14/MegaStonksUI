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
    let hubURL = APIRoutes().server + "/chatHub"
    var hubConnection: HubConnection
    let nc = NotificationCenter.default

    init() {
        hubConnection = HubConnectionBuilder(url: URL(string: hubURL)!)
            .withAutoReconnect()
            .withLogging(minLogLevel: .debug)
            .build()
        
        //Register Event
        hubConnection.on(method: "ReceiveMessage") { (response: PostChatMessageResponse) in
            
            self.nc.post(name: .newMessageReceived, object: nil, userInfo: ["response" : response])
           print("DEBUG1: Receive Message Called")
        }
        
        //Start Connection
        hubConnection.start()
    }
    
    func restartHubConnection(user: ChatUserResponse) {
        
        hubConnection.stop()
        
        hubConnection = HubConnectionBuilder(url: URL(string: hubURL)!)
            .withAutoReconnect()
            .withLogging(minLogLevel: .debug)
            .build()
        
        //Register Event
        hubConnection.on(method: "ReceiveMessage") { (response: PostChatMessageResponse) in
            self.nc.post(name: .newMessageReceived, object: nil, userInfo: ["response" : response])
           print("DEBUG: Receive Message Called")
            
        }
        
        //Start Connection
        hubConnection.start()
        updateConnectionId(user: user)
    }
    
    func sendMessage(user: ChatUserResponse, sessionId: Int, message: String, completion: @escaping (Result<PostChatMessageResponse, Error>) -> ()) {
        let postMessageRequest = PostChatMessageRequest(sender: user, sessionId: sessionId, message: message)
        hubConnection.invoke(method: "SendMessage",
                             postMessageRequest,
                             resultType: PostChatMessageResponse.self)
        { result, error in
            if let error = error {
                print("DEBUG: \(error)")
                completion(.failure(error))
            } else {
                if let result = result {
                    completion(.success(result))
                }
                else{
                    completion(.failure(NSError(domain: "", code: 4, userInfo: [NSLocalizedDescriptionKey :  "Could not send message to User"])))
                }
             
            }
        }
    }
    
    func updateConnectionId(user: ChatUserResponse) {
        hubConnection.invoke(method: "UpdateConnectionID", user.userName){ _ in }
    }
    

    
    
    
    func stopConnection() {
        hubConnection.stop()
    }
}

class ChatAPI {
    static let shared = ChatAPI()
    private let getAdminURL: URL = URL(string: APIRoutes().server + "chat/getAdmin")!
    private let createUserURL: URL = URL(string: APIRoutes().server + "chat/createUser")!
    private let getFeedURL: URL = URL(string: APIRoutes().server + "chat/getFeed")!
    private let startChatURL: URL = URL(string: APIRoutes().server + "chat/startChat")!
    private let saveMessageURL: URL = URL(string: APIRoutes().server + "chat/saveMessage")!
    private let startChatUrl: URL = URL(string: APIRoutes().server + "chat/startChat")!
    private let updateDeviceTokenUrl: URL = URL(string: APIRoutes().server + "chat/updateDeviceToken")!
    private let removeDeviceTokenUrl: URL = URL(string: APIRoutes().server + "chat/removeDeviceToken")!
    
    let decoder = JSONDecoder()
    
    func getAdmin(authCode: String, completion: @escaping (Result<ChatUserResponse, Error>) -> ()) {
        
        let queryItems = [URLQueryItem(name: "authCode", value: "\(authCode)")]
        let requestURL = getAdminURL.appending(queryItems)!
        let request = AppUrlRequest(url: requestURL, httpMethod: "GET").request

        
        
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
                        completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey :  "Please try again with a code"])))
                    }
              
                    return
                    
                }
            }
            
        }
        task.resume()
    }
    
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
    
    func updateDeviceToken(user: ChatUserResponse, deviceToken: String){
        let url = updateDeviceTokenUrl
        let request = AppUrlRequest(url: url, httpMethod: "POST").request
        let jsonData = try! JSONEncoder().encode(UpdateDeviceTokenRequest(chatUser: user, deviceToken: deviceToken))
        
        let task = API().session.uploadTask(with: request, from: jsonData ) { (data, _ , error) in
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
            }
        }
        task.resume()
    }
    
    func removeDeviceToken(user: ChatUserResponse, completion: @escaping (Result<Bool, Error>) -> ()){
        let url = removeDeviceTokenUrl
        let request = AppUrlRequest(url: url, httpMethod: "POST").request
        let jsonData = try! JSONEncoder().encode(user)
        
        let task = API().session.uploadTask(with: request, from: jsonData ) { (data, response , error) in
            
            if error != nil || data == nil {
                print("Client error!")
                print("Error is \(error!)")
                
                completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey : "Error contacting the server. Please Check your internet connection"])))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                
                if httpResponse.statusCode == 200{
                    if let _ = data {
                        completion(.success(true))
                    }
                    return
                }
                else{
                    completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey :  "Could not close Chat Session. Please try again or contact support @ hello@megastonks.com"])))
                    return
                }
            }
        }
        task.resume()
    }
}
