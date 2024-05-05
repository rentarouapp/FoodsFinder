//
//  APIService.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import Foundation
import Combine

protocol APIServiceType {
    func requestWithCombine<Request>(with request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType
    func requestWithSwiftConcurrency<Request>(with request: Request) async throws -> Request.Response where Request: APIRequestType
}

final class APIService: APIServiceType {
    
    private let baseURLString: String
    init(baseURLString: String = "") {
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
}

// Combine
extension APIService {
    // https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?keyword=西東京&key=ee6d7b1b10b24aef&format=json
    func requestWithCombine<Request>(with request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request : APIRequestType {
        guard let request = request.generateURLRequest() else {
            return Fail(error: APIServiceError.invalidRequestError).eraseToAnyPublisher()
        }
        print("DEBUG_URL_CHECK_Combine: \(request.url?.absoluteString ?? "none_url")")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, urlResponse in data }
            //.map { $0.data }
            .mapError { _ in APIServiceError.responseError }
            .decode(type: Request.Response.self, decoder: decoder)
            .mapError(APIServiceError.parseError)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// Swift Concurrency
extension APIService {
    func requestWithSwiftConcurrency<Request>(with request: Request) async throws -> Request.Response where Request: APIRequestType {
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
}

enum APIServiceError: Error {
    case invalidRequestError
    case apiStatusError
    case connectionError(Data)
    case responseError
    case parseError(Error)
}

