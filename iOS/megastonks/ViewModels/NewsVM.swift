//
//  NewsVM.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-07-15.
//

import Foundation

class NewsVM: ObservableObject {
    @Published var news: [NewsElement]
    
    init() {
        self.news = [NewsElement]()
        getNewsAsync()
    }
    
    func getNews(completion: @escaping (RequestResponse) -> ()) {
        var response = RequestResponse()
        API().GetNews(){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(NewsResponse.self, from: result.data!) {
                    response.newsResponse = News(jsonResponse).news
                    response.isSuccessful = true
                    if(response.newsResponse!.count <= 0){
                        response.isSuccessful = false
                    }
                }
            }
            completion(response)
        }
    }
    
    func getNewsAsync() {
        var response = RequestResponse()
        API().GetNews(){ result in
            response = result
            response.isSuccessful = false
            if(result.isSuccessful){
                let decoder = JSONDecoder()
                 if let jsonResponse = try? decoder.decode(NewsResponse.self, from: result.data!) {
                    response.newsResponse = News(jsonResponse).news
                    if(response.newsResponse!.count <= 0){
                        response.isSuccessful = false
                    }
                    else{
                        response.isSuccessful = true
                        DispatchQueue.main.async {
                            self.news  = News(jsonResponse).news
                        }
                    }
                }
            }
        }
    }
    
}
