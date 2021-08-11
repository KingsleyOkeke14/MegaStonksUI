//
//  News.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-10.
//

import Foundation

struct NewsElement: Identifiable, Hashable {
    var id: UUID = UUID()
    var symbol: String
    var publishedDate, title: String
    var image: String
    var site, text: String
    var url: String
    
    init(_ newsElement: NewsResponseElement) {
        self.symbol =  newsElement.symbol ?? ""
        self.publishedDate =  newsElement.publishedDate ?? ""
        self.title =  newsElement.title ?? ""
        self.image =  newsElement.image ?? ""
        self.site =  newsElement.site ?? ""
        self.text =  newsElement.text ?? ""
        self.url =  newsElement.url ?? ""
    }
}


struct News{
    var news:[NewsElement] = [NewsElement]()
    
    init(_ newsResponse: NewsResponse) {
        for newsData in newsResponse{
            
            let newsToAppend = NewsElement(newsData)
            news.append(newsToAppend)
        }
    }
}

