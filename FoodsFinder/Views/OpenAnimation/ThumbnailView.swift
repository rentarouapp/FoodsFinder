//
//  ThumbnailView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/06/01.
//

import SwiftUI

struct ThumbnailView: View {
    @State private var isDetailed: Bool = false
    @Binding var showDetailHero: AppleHero? {
        willSet {
            isDetailed = newValue?.name == appleHero.name
        }
    }
    var appleHero: AppleHero
    
    private let image: Image = Image(systemName: "star")
    private let text: String = "test"
    
    private var width: CGFloat {
        isDetailed ? UIScreen.main.bounds.width : UIScreen.main.bounds.width - 16 * 2
    }
    
    private var height: CGFloat {
        isDetailed ? UIScreen.main.bounds.height : 300
    }
    
    private var viewTapGesture: some Gesture {
        TapGesture()
            .onEnded {
                withAnimation(.spring()) {
                    if showDetailHero == nil {
                        showDetailHero = appleHero
                    } else {
                        showDetailHero = nil
                    }
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
