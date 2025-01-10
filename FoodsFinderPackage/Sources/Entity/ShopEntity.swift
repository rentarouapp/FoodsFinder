//
//  ShopEntity.swift
//  FoodsFinderPackage
//
//  Created by 上條蓮太朗 on 2024/12/31.
//

import Foundation

public struct ShopInfoResponse: Codable {
    public let result: Result?
    
    public init(result: Result?) {
        self.result = result
    }
    
    public enum CodingKeys: String, CodingKey {
        case result = "results"
    }
}

public struct Result: Codable {
    public let shops: [Shop]?
    
    public enum CodingKeys: String, CodingKey {
        case shops = "shop"
    }
}

public struct Shop: Codable, Identifiable, Equatable {
    public let id: String?
    public let name: String?
    public let logoImage: String?
    public let address: String?
    public let stationName: String?
    public let urlObj: ShopUrl?
    public let shopPhoto: ShopPhoto?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoImage
        case address
        case stationName
        case urlObj = "urls"
        case shopPhoto = "photo"
    }
}

public struct ShopUrl: Codable, Equatable {
    public let pc: String?
}

public struct ShopPhoto: Codable, Equatable {
    public let mobilePhotoObj: ShopPhotoMobile?
    public enum CodingKeys: String, CodingKey {
        case mobilePhotoObj = "mobile"
    }
}

public struct ShopPhotoMobile: Codable, Equatable {
    public let large: String?
    public let small: String?
    public enum CodingKeys: String, CodingKey {
        case large = "l"
        case small = "s"
    }
}

public class Mock {
    public static let shop1 = Shop(id: "0", name: "テスト1", logoImage: "", address: "", stationName: "", urlObj: ShopUrl(pc: ""), shopPhoto: ShopPhoto(mobilePhotoObj: ShopPhotoMobile(large: "", small: "")))
    public static let shop2 = Shop(id: "1", name: "テスト2", logoImage: "", address: "", stationName: "", urlObj: ShopUrl(pc: ""), shopPhoto: ShopPhoto(mobilePhotoObj: ShopPhotoMobile(large: "", small: "")))
}
