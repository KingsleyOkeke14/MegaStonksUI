//
//  AdData.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-05-04.
//

import Foundation

struct AdData: Identifiable, Hashable{
    var id: UUID = UUID()
    var title: String
    var description: String
    var imageUrl: String
    var urlToLoad: String
    
    init(title: String, description: String, imageUrl: String, urlToLoad: String) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.urlToLoad = urlToLoad
    }
}
