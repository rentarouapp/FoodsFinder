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
        ScrollView {
            VStack {
                Text("🍺")
                    .font(.system(size: 60, weight: .black, design: .default))
                Spacer().frame(height: 10)
                HStack {
                    Text("ID：")
                        .font(.system(size: 20, weight: .black, design: .default))
                    Text(shop.id ?? "")
                        .font(.system(size: 20, weight: .black, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(minHeight: 40)
                HStack {
                    Text("店名：")
                        .font(.system(size: 20, weight: .black, design: .default))
                    Text(shop.name ?? "")
                        .font(.system(size: 20, weight: .black, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(minHeight: 40)
                HStack {
                    Text("ロゴURL：")
                        .font(.system(size: 20, weight: .black, design: .default))
                    Text(shop.logoImage ?? "")
                        .font(.system(size: 20, weight: .black, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(minHeight: 40)
                HStack {
                    Text("住所：")
                        .font(.system(size: 20, weight: .black, design: .default))
                    Text(shop.address ?? "")
                        .font(.system(size: 20, weight: .black, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(minHeight: 40)
                HStack {
                    Text("駅名：")
                        .font(.system(size: 20, weight: .black, design: .default))
                    Text(shop.stationName ?? "")
                        .font(.system(size: 20, weight: .black, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(minHeight: 40)
                HStack {
                    Text("お店URL：")
                        .font(.system(size: 20, weight: .black, design: .default))
                    Text(shop.urlObj?.pc ?? "")
                        .font(.system(size: 20, weight: .black, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(minHeight: 40)
                HStack {
                    Text("店内画像：")
                        .font(.system(size: 20, weight: .black, design: .default))
                    Text(shop.shopPhoto?.mobilePhotoObj?.large ?? "")
                        .font(.system(size: 20, weight: .black, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(minHeight: 40)
                Spacer().frame(maxHeight: .infinity)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ShopDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ShopDescriptionView(shop: Mock.shop1)
    }
}
