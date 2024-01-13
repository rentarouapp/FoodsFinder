//
//  PKHUDModifire.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import SwiftUI
import PKHUD

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
