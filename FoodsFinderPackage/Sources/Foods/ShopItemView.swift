//
//  ShopItemView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import SwiftUI

public struct ShopItemView: View {
    
    var shop: Shop
    
    public init(shop: Shop) {
        self.shop = shop
    }
    
    public var body: some View {
        HStack {
            Text("🍺")
                .font(.system(size: 60, weight: .black, design: .default))
            Text(shop.name ?? "")
                .font(.system(size: 20, weight: .black, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

struct ShopItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShopItemView(shop: Mock.shop1)
    }
}
