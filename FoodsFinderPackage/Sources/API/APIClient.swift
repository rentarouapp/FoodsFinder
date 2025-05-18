//
//  APIClient.swift
//  FoodsFinderPackage
//
//  Created by 上條蓮太朗 on 2025/01/11.
//

import Foundation

public protocol APIClientProtocol: Sendable {
    func fetch<Request>(with request: Request) async throws -> Request.Response where Request: APIRequestType
    func fetch(with keyword: String) async throws -> ShopInfoRequest.Response
}

public final class APIClient: APIClientProtocol {
    private let baseURLString: String
    public init(baseURLString: String = "") {
        self.baseURLString = baseURLString
    }
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    public func fetch<Request>(with request: Request) async throws -> Request.Response where Request: APIRequestType {
        guard let request = request.generateURLRequest() else {
            throw APIServiceError.invalidRequestError
        }
        print("DEBUG_URL_CHECK_Concurrency: \(request.url?.absoluteString ?? "none_url")")
        let result = try await session.data(for: request)
        let data = result.0
        let response = result.1
        
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw APIServiceError.connectionError(data)
        }
        guard (200..<300).contains(code) else {
            throw APIServiceError.apiStatusError
        }
        return try decoder.decode(Request.Response.self, from: data)
    }
    
    public func fetch(with keyword: String) async throws -> ShopInfoRequest.Response {
        guard let request = ShopInfoRequest(keyword: keyword).generateURLRequest() else {
            throw APIServiceError.invalidRequestError
        }
        print("DEBUG_URL_CHECK_Concurrency_Dependency: \(request.url?.absoluteString ?? "none_url")")
        let result = try await session.data(for: request)
        let data = result.0
        let response = result.1
        
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw APIServiceError.connectionError(data)
        }
        guard (200..<300).contains(code) else {
            throw APIServiceError.apiStatusError
        }
        return try decoder.decode(ShopInfoRequest.Response.self, from: data)
    }
}
