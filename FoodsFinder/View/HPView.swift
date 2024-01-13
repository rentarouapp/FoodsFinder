//
//  HPView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import SwiftUI

struct HPView: View {
    
    var body: some View {
        TabView {
            HPListView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("検索")
                    }
                }.tag(1)
            FavoritesListView()
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                        Text("お気に入り")
                    }
                }.tag(2)
            SettingView()
                .tabItem {
                    VStack {
                        Image(systemName: "gearshape")
                        Text("設定")
                    }
                }.tag(3)
        }
    }
}

#Preview {
    HPView()
}

