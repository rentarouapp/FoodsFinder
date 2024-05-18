//
//  RootViews.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/05/18.
//

import SwiftUI

// MARK: - Use NavitaionView
struct RootView: View {
    @State var isActive : Bool = false
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: __RedView(shouldPopToRootView: $isActive), isActive: $isActive) {
                Text("To Red")
                    .setContentButton(color: .red)
            }
            .isDetailLink(false)
            .navigationTitle("Root View")
        }
    }
}

#Preview {
    RootView()
}

// MARK: - Use NavitaionStack 1
enum Path: String, Hashable {
    case red, green, blue
}

struct Root1View: View {
    @State private var path = [Path]()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button(action: {
                    path.append(.red)
                } ,label: {
                    Text("To Red")
                })
                .setContentButton(color: .red)
            }
            .navigationTitle("Root1 View")
            .navigationDestination(for: Path.self) { path in
                switch path {
                case .red:
                    _RedView(path: $path)
                case .green:
                    _GreenView(path: $path)
                case .blue:
                    _BlueView(path: $path)
                }
            }
        }
    }
}

#Preview {
    Root1View()
}

// MARK: - Use NavitaionStack 2
struct Root2View: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var body: some View {
        NavigationStack(path: $navigationRouter.destinations) {
            VStack {
                Button(action: {
                    navigationRouter.to(.red)
                } ,label: {
                    Text("To Red")
                })
                .setContentButton(color: .red)
            }
            .navigationTitle("Root2 View")
            .setNavigationDestination()
        }
    }
}

#Preview {
    Root2View()
        .environmentObject(NavigationRouter())
}

