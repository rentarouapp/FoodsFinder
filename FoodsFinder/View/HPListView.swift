//
//  HPListView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import SwiftUI

struct HPListView: View {
    
    @State private var searchText: String = ""
    
    private let shops: [Shop] = [
        Mock.shop1,
        Mock.shop2
    ]
    
    var body: some View {
        NavigationStack {
            List(shops) { shop in
                ZStack {
                    NavigationLink(destination:
                                    ShopDescriptionView()
                        .toolbarRole(.editor) // Backは非表示にする
                    ) {
                        EmptyView()
                    }
                    // NavigationLinkの右の矢印を消す
                    .opacity(0)
                    ShopItemView(shop: shop)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("お店を探す")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchText, prompt: "なんでも入力してね")
    }
}

struct HPListView_Previews: PreviewProvider {
    static var previews: some View {
        HPListView()
    }
}
