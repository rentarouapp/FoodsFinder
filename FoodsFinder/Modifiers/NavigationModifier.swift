//
//  NavigationModifier.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/05/18.
//

import SwiftUI

struct NavigationDestination: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: NavigationRouter.Destination.self) { item in
                switch item {
                case .red:
                    RedView()
                case .green:
                    GreenView()
                case .blue:
                    BlueView()
                }
            }
    }
}

struct ContentButton: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 300)
            .font(.largeTitle).bold()
            .foregroundColor(Color.white)
            .background(color, in: RoundedRectangle(cornerRadius: 10))
    }
}

struct BackButtons: ViewModifier {
    @EnvironmentObject var navigationRouter: NavigationRouter
    func body(content: Content) -> some View {
        VStack {
            content
            Button(action: {
                navigationRouter.pop()
            } ,label: {
                Text("Pop")
            })
            .setContentButton(color: .black)
            
            Button(action: {
                navigationRouter.popToRoot()
            } ,label: {
                Text("Pop To Root")
            })
            .setContentButton(color: .black)
        }
    }
}
