//
//  Extension.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/05/10.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
