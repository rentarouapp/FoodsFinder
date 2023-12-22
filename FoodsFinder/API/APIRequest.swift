//
//  APIRequest.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import Foundation

protocol APIRequestType {
    associatedtype Response: Decodable
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

struct ShopInfoRequest: APIRequestType {
    typealias Response = ShopInfoResponse
    
    var path: String {
        return ""
    }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "", value: self.searchWord),
            .init(name: "", value: "\(self.maxResults)")
        ]
    }
    
    public let searchWord: String
    public let maxResults: Int
    
    init(searchWord: String, maxResults: Int) {
        self.searchWord = searchWord
        self.maxResults = maxResults
    }
    
}
