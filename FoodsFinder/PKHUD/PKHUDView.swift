//
//  PKHUDView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import SwiftUI
import PKHUD

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
