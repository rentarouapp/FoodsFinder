//
//  ThumbnailDetailView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/06/22.
//

import SwiftUI

struct ThumbnailDetailView: View {
    @Binding var showDetailHero: AppleHero?
    
    private var viewTapGesture: some Gesture {
        TapGesture()
            .onEnded {
                withAnimation(.spring()) {
                    showDetailHero = nil
                }
            }
    }
    
    var body: some View {
        VStack {
            Image(showDetailHero?.imageName ?? "")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .gesture(viewTapGesture)
        }
        .background(Color.clear)
        .ignoresSafeArea()
    }
}

#Preview {
    ThumbnailDetailView(showDetailHero: .constant(.tim))
}
