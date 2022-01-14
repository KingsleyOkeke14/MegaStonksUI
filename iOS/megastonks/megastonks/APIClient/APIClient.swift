//
//  APIClient.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-01-09.
//

import Foundation
import Combine

class APIClient {
    
    struct APIRoutes {
        let server:String
        #if DEBUG
        let domain = "megastonksdev.azurewebsites.net"
        #else
        let domain = "megastonksprod.azurewebsites.net"
        #endif
        
        //Account
        private let authRoute = "account/authenticate"
        private let registerRoute = "account/register"
        
        var auth: URL
        var register: URL
        
        init() {
            server = "https://\(domain)/"
            auth = URL(string: server + authRoute)!
            register = URL(string: server + registerRoute)!
        }
    }
    
    struct APIRequest {
        var request:URLRequest
        
        init(url:URL, httpMethod:String, authToken: String = "") {
            request = URLRequest(url: url)
            request.httpMethod = httpMethod
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }
    }
    
    enum APIError: Error {
        case invalidClient
        case invalidURL
        case responseError
        case unknown
    }
    
    let shared = APIClient()
    var routes: APIRoutes = APIRoutes()
    private var cancellables = Set<AnyCancellable>()
    
    func getData<T: Decodable>(request: APIRequest, type: T.Type) -> Future<[T], Error> {
         return Future<[T], Error> { [weak self] promise in
             guard let self = self else { return promise(.failure(APIError.invalidClient)) }
             URLSession.shared.dataTaskPublisher(for: request.request)
                 .tryMap { (data, response) -> Data in
                     guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                         throw APIError.responseError
                     }
                     return data
                 }
                 .decode(type: [T].self, decoder: JSONDecoder())
                 .receive(on: RunLoop.main)
                 .sink(receiveCompletion: { (completion) in
                     if case let .failure(error) = completion {
                         switch error {
                         case let decodingError as DecodingError:
                             promise(.failure(decodingError))
                         case let apiError as APIError:
                             promise(.failure(apiError))
                         default:
                             promise(.failure(APIError.unknown))
                         }
                     }
                 }, receiveValue: { promise(.success($0)) })
                 .store(in: &self.cancellables)
         }
     }
}
