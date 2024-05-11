//
//  ShopsListView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import SwiftUI

struct ShopsListView: View {
    
    // ViewModel
    @StateObject private var hpViewModel = ShopsFetchViewModel()
    @FocusState var focus: Bool
    @State private var searchText: String = ""

    
    var body: some View {
        let shops = self.hpViewModel.shopInfoResponse.result?.shops ?? []
        
        NavigationStack {
            List(shops) { shop in
                ZStack {
                    NavigationLink(destination:
                                    ShopDescriptionView(shop: shop)
                        .toolbarRole(.editor) // Backは非表示にする
                    ) {
                        EmptyView()
                    }
                    // NavigationLinkの右の矢印を消す
                    .opacity(0)
                    ShopItemView(shop: shop)
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("お店を探す")
            .navigationBarHidden(false)
        }
        .listStyle(.plain)
        .searchable(text: $searchText, prompt: "なんでも入力してね")
        .onChange(of: searchText) { newValue in
            // 検索バーの文字列が更新された
            if newValue == "" {
                // クリアボタンがおされた
                self.focus = false
                self.hpViewModel.cancel()
                //self.hpViewModel.type = .initial
            }
        }
        .onSubmit(of: .search) {
            // 決定キー押された
            if !self.searchText.isEmpty {
                self.focus = false
                self.hpViewModel.resumeSearch(keyword: self.searchText)
            }
        }
        .focused(self.$focus)
        .PKHUD(isPresented: $hpViewModel.isFetching, HUDContent: .progress)
    }
}

struct HPListView_Previews: PreviewProvider {
    static var previews: some View {
        ShopsListView()
    }
}
