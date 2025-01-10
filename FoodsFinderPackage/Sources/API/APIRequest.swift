//
//  APIRequest.swift
//  FoodsFinderPackage
//
//  Created by 上條蓮太朗 on 2025/01/02.
//

import Foundation
import Entity

public protocol APIRequestType {
    associatedtype Response: Decodable
    
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    func generateURLRequest() -> URLRequest?
}

public struct ShopInfoRequest: APIRequestType {
    
    let hpSearchURLBaseString: String = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
    let hpApiKey = "59a38c7007ae784b"
    
    public typealias Response = ShopInfoResponse
    
    public var path: String {
        return hpSearchURLBaseString
    }
    public var queryItems: [URLQueryItem]? {
        return [
            .init(name: "keyword", value: self.keyword),
            .init(name: "key", value: hpApiKey),
            .init(name: "format", value: "json")
        ]
    }
    public let keyword: String
    public init(keyword: String) {
        self.keyword = keyword
    }
    
    public func generateURLRequest() -> URLRequest? {
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
