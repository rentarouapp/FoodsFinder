//
//  ShopFeature.swift
//  FoodsFinderPackage
//
//  Created by 上條蓮太朗 on 2024/12/31.
//

import SwiftUI
import ComposableArchitecture
import Entity
import API

@Reducer
public struct ShopsFeature {
    @ObservableState
    public struct State: Equatable {
        public var shops = Array<Shop>()
        public var isFetching = false
        public init() {}
    }
    
    public enum Action: Equatable {
        case fetchShops(String) // キーワードをもらってお店一覧を取る
        case setShops([Shop]) // 取れたお店をStateにセットする
        case resetShops // お店一覧をリセット
    }
    
    @Dependency(\.apiClient) private var apiClient
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .fetchShops(keyword):
                state.isFetching = true
                return .run { send in
                    let shops = try await apiClient.fetch(with: keyword).result?.shops ?? []
                    await send(
                        .setShops(shops)
                    )
                }
                
            case let .setShops(shops):
                state.isFetching = false
                state.shops = shops
                return .none
                
            case .resetShops:
                state.shops = []
                return .none
            }
        }
    }
}
