//
//  NavigationExampleTopView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/05/18.
//

import SwiftUI

struct NavigationExampleTopView: View {
    @State private var tabType: NavigationRouter.TabType = .root
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var body: some View {
        TabView(selection: $tabType) {
            ForEach(NavigationRouter.TabType.allCases) { type in
                switch type {
                case .root:
                    RootView()
                        .tag(type)
                        .tabItem {
                            Image(systemName: type.imageName)
                            Text(type.title)
                        }
                case .root1:
                    Root1View()
                        .tag(type)
                        .tabItem {
                            Image(systemName: type.imageName)
                            Text(type.title)
                        }
                case .root2:
                    Root2View()
                        .tag(type)
                        .tabItem {
                            Image(systemName: type.imageName)
                            Text(type.title)
                        }
                }
            }
        }
        .onChange(of: tabType) { newValue in
            navigationRouter.setTabIndex(tabType)
        }
    }
}

#Preview {
    NavigationExampleTopView()
}
