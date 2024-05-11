//
//  ShopInfo.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import Foundation

struct ShopInfoResponse: Codable {
    let result: Result?
    
    enum CodingKeys: String, CodingKey {
        case result = "results"
    }
}

struct Result: Codable {
    let shops: [Shop]?
    
    enum CodingKeys: String, CodingKey {
        case shops = "shop"
    }
}

struct Shop: Codable, Identifiable {
    let id: String?
    let name: String?
    let logoImage: String?
    let address: String?
    let stationName: String?
    let urlObj: ShopUrl?
    let shopPhoto: ShopPhoto?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoImage
        case address
        case stationName
        case urlObj = "urls"
        case shopPhoto = "photo"
    }
}

struct ShopUrl: Codable {
    let pc: String?
}

struct ShopPhoto: Codable {
    let mobilePhotoObj: ShopPhotoMobile?
    enum CodingKeys: String, CodingKey {
        case mobilePhotoObj = "mobile"
    }
}

struct ShopPhotoMobile: Codable {
    let large: String?
    let small: String?
    enum CodingKeys: String, CodingKey {
        case large = "l"
        case small = "s"
    }
}
