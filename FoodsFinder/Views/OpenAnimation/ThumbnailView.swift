//
//  ThumbnailView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/06/01.
//

import SwiftUI

struct ThumbnailView: View {
    @Binding var showDetailHero: AppleHero?
    var appleHero: AppleHero
    
    private let text: String = "test"
    
    private var width: CGFloat {
        UIScreen.main.bounds.width - 16 * 2
    }
    
    private var height: CGFloat {
        300
    }
    
    private var viewTapGesture: some Gesture {
        TapGesture()
            .onEnded {
                withAnimation(.spring()) {
                    showDetailHero = appleHero
                }
            }
    }
    
    var body: some View {
        VStack {
            Image(appleHero.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: 300)
            .cornerRadius(20)
            .gesture(viewTapGesture)
        }
        .background(Color.clear)
    }
}

#Preview {
    ThumbnailView(showDetailHero: .constant(nil), appleHero: .tim)
}
