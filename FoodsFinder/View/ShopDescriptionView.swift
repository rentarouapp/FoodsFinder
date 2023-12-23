//
//  ShopDescriptionView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import SwiftUI

struct ShopDescriptionView: View {
    
    var shop: Shop
    
    var body: some View {
        VStack {
            Text("🍺")
                .font(.system(size: 60, weight: .black, design: .default))
            Spacer().frame(height: 10)
            Text(shop.name ?? "")
                .font(.system(size: 20, weight: .black, design: .default))
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

struct ShopDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ShopDescriptionView(shop: Mock.shop1)
    }
}
