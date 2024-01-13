//
//  ViewExtension.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import SwiftUI
import PKHUD

extension View {
    public func PKHUD(isPresented: Binding<Bool>, HUDContent: HUDContentType) -> some View {
        PKHUDModifier(isPresented: isPresented, hudContent: HUDContent, parent: self)
    }
}
