//
//  PKHUDView.swift
//  FoodsFinderPackage
//
//  Created by 上條蓮太朗 on 2025/03/09.
//

import SwiftUI
import PKHUD

extension View {
    // HUD表示
    public func PKHUD(isPresented: Binding<Bool>, HUDContent: HUDContentType) -> some View {
        PKHUDModifier(isPresented: isPresented, hudContent: HUDContent, parent: self)
    }
}

struct PKHUDView: UIViewRepresentable {
    
    @Binding var isPresented: Bool
    var hudContent: HUDContentType
    
    func makeUIView(context: UIViewRepresentableContext<PKHUDView>) -> some UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<PKHUDView>) {
        if isPresented {
            HUD.show(hudContent)
        } else {
            HUD.hide()
        }
    }
}

struct PKHUDModifier<Parent: View>: View {
    
    @Binding var isPresented: Bool
    var hudContent: HUDContentType
    var parent: Parent
    
    var body: some View {
        ZStack {
            parent
            if isPresented {
                PKHUDView(isPresented: $isPresented, hudContent: hudContent)
            }
        }
    }
}
