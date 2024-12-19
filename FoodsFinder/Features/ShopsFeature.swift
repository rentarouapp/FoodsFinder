//
//  ShopsFeature.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/12/19.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct ShopsFeature {
    @ObservableState
    struct State: Equatable {
        var shops = Array<Shop>()
    }
    
    enum Action: Equatable {
        case fetchShops(String) // キーワードをもらってお店一覧を取る
        case setShops([Shop]) // 取れたお店をStateにセットする
        case resetShops // お店一覧をリセット
    }
    
    private let apiService = APIService()
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .fetchShops(keyword):
                return .run { send in
                    let request = ShopInfoRequest(keyword: keyword)
                    let shops = try await apiService.requestWithSwiftConcurrency(with: request).result?.shops ?? []
                    await send(
                        .setShops(shops)
                    )
                }
                
            case let .setShops(shops):
                state.shops = shops
                return .none
                
            case .resetShops:
                return .none
            }
        }
    }
}
