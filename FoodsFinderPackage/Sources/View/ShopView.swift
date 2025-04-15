//
//  ShopView.swift
//  FoodsFinderPackage
//
//  Created by 上條蓮太朗 on 2025/01/02.
//

import SwiftUI
import Core
import ComposableArchitecture

public struct ShopWrapView: View {
    
    public init() {}
    
    public var body: some View {
        ShopView(store: Store(
            initialState: ShopsFeature.State(),
            reducer: {
                ShopsFeature()
        }))
    }
}

public struct ShopView: View {
    @FocusState var focus: Bool
    @State private var searchText: String = ""
    
    // iOS17+ターゲットなら`@Bindable`とするだけでOK
    @Perception.Bindable var store: StoreOf<ShopsFeature>
    
    public var body: some View {
        WithPerceptionTracking {
            // iOS17未満をターゲットにしているならWithPerceptionTrackingでラップする必要がある
            // メインスレッドチェッカーが動いちゃう
            NavigationStack {
                List(store.shops) { shop in
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
                    self.store.send(.resetShops)
                }
            }
            .onSubmit(of: .search) {
                // 決定キー押された
                if !self.searchText.isEmpty {
                    self.focus = false
                    self.store.send(.fetchShops(self.searchText))
                }
            }
            .focused(self.$focus)
            .PKHUD(isPresented: $store.isFetching, HUDContent: .progress)
        }
    }
}

#Preview {
    ShopView(store: Store(
        initialState: ShopsFeature.State(),
        reducer: {
            ShopsFeature()
    }))
}
