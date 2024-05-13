//
//  ShopsGridView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/05/12.
//

import SwiftUI

struct ShopsGridView: View {
    @FocusState var focus: Bool
    @State private var searchText: String = ""
    @StateObject private var shopsFetchViewModel = ShopsFetchViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ShopsGridViewControllerWrapper(keyword: searchText,
                                               shopsFetchViewModel: shopsFetchViewModel)
                .navigationTitle("お店を探す")
                
                if shopsFetchViewModel.shopInfoResponse.result?.shops?.isEmpty ?? true {
                    Color(.white)
                    if shopsFetchViewModel.isSearched {
                        Text("検索結果なし")
                    } else {
                        Text("なにもなし")
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            if newValue == "" {
                // クリアボタンがおされた
                self.focus = false
                self.shopsFetchViewModel.cancel()
            }
        }
        .onSubmit(of: .search) {
            if !searchText.isEmpty {
                focus = false
                shopsFetchViewModel.resumeSearch(keyword: searchText)
            }
        }
        .focused(self.$focus)
        .PKHUD(isPresented: $shopsFetchViewModel.isFetching, HUDContent: .progress)
    }
}

#Preview {
    ShopsGridView()
}
