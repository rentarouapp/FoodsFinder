//
//  OpenAnimationView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/06/01.
//

import SwiftUI

struct OpenAnimationView: View {
    @State private var showDetailHero: AppleHero?
    
    var body: some View {
        NavigationStack() {
            ScrollView {
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 1),
                          spacing: 14) {
                    ForEach(AppleHero.allCases, id: \.self) {
                        ThumbnailView(showDetailHero: $showDetailHero, appleHero: $0)
                    }
                }
            }
            .navigationTitle("Apple Heroes")
        }
    }
}

#Preview {
    OpenAnimationView()
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
}
