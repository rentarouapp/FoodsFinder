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
        var shops: [Shop] = []
    }
    
    enum Action: Equatable {
        case testA
        case testB
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .testA:
                return .none
                
            case .testB:
                return .none
            }
        }
    }
}
