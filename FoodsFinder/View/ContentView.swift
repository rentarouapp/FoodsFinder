//
//  ContentView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresentLoginView = false
    
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
        }
        .onAppear {
            isPresentLoginView = true
        }
        .fullScreenCover(isPresented: $isPresentLoginView) {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
