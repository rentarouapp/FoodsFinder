//
//  View+Extension.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2025/03/09.
//

import SwiftUI

extension View {
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
