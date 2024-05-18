//
//  NavigationRouter.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/05/18.
//

import Foundation

@MainActor
class NavigationRouter: ObservableObject {
    // タブの選択状態
    private var currentTabIndex: TabType = .root
    // Navigationのパス
    @Published var destinations = [Destination]()
}

// MARK: - Router Destinations
extension NavigationRouter {
    enum Destination: Hashable {
        case red
        case green
        case blue
    }
}

// MARK: - Router Navigation Methods
extension NavigationRouter {
    func to(_ dest: Destination) {
        switch currentTabIndex {
        case .root2:
            destinations.append(dest)
        default:
            break
        }
    }
    
    func toThrough(_ dests: [Destination]) {
        switch currentTabIndex {
        case .root2:
            dests.forEach {
                destinations.append($0)
            }
        default:
            break
        }
    }
    
    func pop() {
        switch currentTabIndex {
        case .root2:
            if destinations.isEmpty { return }
            destinations.removeLast()
        default:
            break
        }
    }
    
    func popToRoot() {
        switch currentTabIndex {
        case .root2:
            destinations.removeAll()
        default:
            break
        }
    }
}

// MARK: - Bottom Tab
extension NavigationRouter {
    enum TabType: Int, Identifiable, CaseIterable {
        case root = 0
        case root1
        case root2
        
        var id: Int {
            return rawValue
        }
        
        var imageName: String {
            switch self {
            case .root:
                return "pencil"
            case .root1:
                return "hand.thumbsdown"
            case .root2:
                return "hand.thumbsup"
            }
        }
        
        var title: String {
            switch self {
            case .root:
                return "deprecated"
            case .root1:
                return "bad"
            case .root2:
                return "good"
            }
        }
    }
    
    // タブの選択状態が変わったときに呼ばれる
    func setTabIndex(_ tabType: TabType) {
        currentTabIndex = tabType
    }
}
