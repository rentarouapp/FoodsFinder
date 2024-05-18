//
//  ViewExtension.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import SwiftUI
import PKHUD

extension View {
    // HUD表示
    public func PKHUD(isPresented: Binding<Bool>, HUDContent: HUDContentType) -> some View {
        PKHUDModifier(isPresented: isPresented, hudContent: HUDContent, parent: self)
    }
    // アラート表示
    func customAlert(for alertEntity: Binding<CustomAlertEntity>) -> some View {
        modifier(CustomAlertModifier(alertEntity: alertEntity))
    }
}

// MARK: - Navigation Example
extension View {
    func setNavigationDestination() -> some View {
        modifier(NavigationDestination())
    }
    
    func setContentButton(color: Color) -> some View {
        modifier(ContentButton(color: color))
    }
    
    func setBackButtons() -> some View {
        modifier(BackButtons())
    }
}
