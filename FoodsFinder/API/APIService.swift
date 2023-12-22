//
//  APIService.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import Foundation
import Combine

protocol APIServiceType {
    func request<Request>(with request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType
}

final class APIService: APIServiceType {
    
    private let baseURLString: String
    init(baseURLString: String = "") {
        self.baseURLString = baseURLString
    }
    
    func request<Request>(with request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request : APIRequestType {
        guard let pathURL = URL(string: request.path, relativeTo: URL(string: self.baseURLString)) else {
            return Fail(error: APIServiceError.invalidURL).eraseToAnyPublisher()
        }
        guard var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true) else {
            return Fail(error: APIServiceError.invalidURL).eraseToAnyPublisher()
        }
        // ここでurlComponentsに対してqueryのSettingもいける
        urlComponents.queryItems = request.queryItems
        
        guard let _url = urlComponents.url else {
            return Fail(error: APIServiceError.invalidURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: _url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Request Header
        // トークンの設定もいける
        //request.addValue("トークン", forHTTPHeaderField: "X-Mobile-Token")
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        print("DEBUG_URL_CHECK: \(request.url?.absoluteString ?? "none_url")")
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

enum APIServiceError: Error {
    case invalidURL
    case responseError
    case parseError(Error)
}

