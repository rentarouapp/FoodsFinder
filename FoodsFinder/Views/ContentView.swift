//
//  ContentView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        // MARK: - CompositionalLayout/DiffableDatasourceのサンプル
        //ShopsGridView()
        
        // MARK: - Combine/Swift Concurrencyのリクエストサンプル
        //ShopsListView()
        
        // MARK: - ナビゲーションのサンプル
//        NavigationExampleTopView()
//            .environmentObject(NavigationRouter())
        
        // MARK: - タップ時アニメーションのサンプル
        OpenAnimationView()
    }
}

#Preview {
    ContentView()
}
