//
//  ShopInfo.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import Foundation

struct ShopInfoResponse: Codable {
    let results: Result?
}

struct Result: Codable {
    let shop: [Shop]?
}

struct Shop: Codable, Identifiable {
    let id: String?
    var name: String?
}
