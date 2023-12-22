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
            .init(name: "keyword", value: self.keyword),
            .init(name: "key", value: Constants.hpApiKey),
            .init(name: "format", value: "json")
        ]
    }
    public let keyword: String
    init(keyword: String) {
        self.keyword = keyword
    }
    
}
