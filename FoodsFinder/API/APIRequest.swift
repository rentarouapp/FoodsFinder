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
    func generateURLRequest() -> URLRequest?
}

struct ShopInfoRequest: APIRequestType {
    typealias Response = ShopInfoResponse
    
    var path: String {
        return Constants.hpSearchURLBaseString
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
    
    func generateURLRequest() -> URLRequest? {
        guard let pathURL = URL(string: path, relativeTo: URL(string: path)),
              var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true) else {
            return nil
        }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Request Header
        // トークンの設定もいける
        //request.addValue("トークン", forHTTPHeaderField: "X-Mobile-Token")
        return request
    }
    
}
