//
//  OpenAnimationView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/06/01.
//

import SwiftUI

struct OpenAnimationView: View {
    @State private var showDetailHero: AppleHero?
    
    private var axes: Axis.Set {
        showDetailHero != nil ? [] : [.vertical]
    }
    
    var body: some View {
        ScrollView(axes) {
            VStack(spacing: 20) {
                if showDetailHero == nil {
                    Spacer().frame(height: 50)
                    Text("Apple Heroes")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                }
                if showDetailHero == .tim || showDetailHero == nil {
                    ThumbnailView(showDetailHero: $showDetailHero, appleHero: .tim)
                }
                if showDetailHero == .crag || showDetailHero == nil {
                    ThumbnailView(showDetailHero: $showDetailHero, appleHero: .crag)
                }
                if showDetailHero == .john || showDetailHero == nil {
                    ThumbnailView(showDetailHero: $showDetailHero, appleHero: .john)
                }
                if showDetailHero == .jony || showDetailHero == nil {
                    ThumbnailView(showDetailHero: $showDetailHero, appleHero: .jony)
                }
                if showDetailHero == .jobs || showDetailHero == nil {
                    ThumbnailView(showDetailHero: $showDetailHero, appleHero: .jobs)
                }
                Spacer().frame(height: 50)
            }
        }
        .ignoresSafeArea()
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
