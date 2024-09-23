//
//  OpenAnimationView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/06/01.
//

import SwiftUI

struct OpenAnimationView: View {
    @State private var showDetailHero: AppleHero?
    @Namespace var namespace
    
    var body: some View {
        NavigationStack() {
            if let showDetailHero {
                VStack {
                    ThumbnailDetailView(showDetailHero: $showDetailHero)
                        .matchedGeometryEffect(id: showDetailHero.name, in: namespace)
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 1),
                              spacing: 14) {
                        ForEach(AppleHero.allCases, id: \.self) { appleHero in
                            ThumbnailView(showDetailHero: $showDetailHero, appleHero: appleHero)
                                .matchedGeometryEffect(id: appleHero.name, in: namespace, isSource: true)
                        }
                    }
                }
                .navigationTitle("Apple Heroes")
            }
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
