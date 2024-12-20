//
//  ContentView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import SwiftUI
import ComposableArchitecture
import CocoaNetworkingMonitor

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    
    // ネットワーク監視
    @StateObject private var provider = CocoaNetworkingProvider()
    private let monitor = CocoaNetworkingMonitor.shared
    
    var body: some View {
        // MARK: - TCAを使ってリクエスト等するサンプル
        ShopsFeatureView(store: Store(
            initialState: ShopsFeature.State(),
            reducer: {
                ShopsFeature()
        }))
        
        // MARK: - CompositionalLayout/DiffableDatasourceのサンプル
        //ShopsGridView()
        
        // MARK: - Combine/Swift Concurrencyのリクエストサンプル
        //ShopsListView()
        
        // MARK: - ナビゲーションのサンプル
        //        NavigationExampleTopView()
        //            .environmentObject(NavigationRouter())
        
        // MARK: - タップ時アニメーションのサンプル
//        OpenAnimationView()
//            .onChange(of: scenePhase) { phase in
//                switch phase {
//                case .active:
//                    monitor.startMonitoring()
//                case .background:
//                    monitor.cancelMonitoring()
//                default:
//                    break
//                }
//            }
//            .alert("ネットワークエラー",
//                   isPresented: $provider.isShowUnsatisfiedAlert,
//                   actions: {
//                
//            }, message: {
//                Text("ネットワークの接続が切れました")
//            })
    }
}

#Preview {
    ContentView()
}
