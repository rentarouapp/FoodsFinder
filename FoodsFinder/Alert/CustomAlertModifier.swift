//
//  CustomAlertView.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import SwiftUI

struct CustomAlertModifier: ViewModifier {
    
    @Binding var alertEntity: CustomAlertEntity
    func body(content: Content) -> some View {
        switch alertEntity.buttonType {
        case .singleButton:
            content
                .alert(alertEntity.title, isPresented: $alertEntity.isShowingAlert) {
                    Button(alertEntity.negativeTitle) { alertEntity.buttonAction() }
                } message: {
                    Text(alertEntity.message)
                }
        case .doubleButton:
            content
                .alert(alertEntity.title, isPresented: $alertEntity.isShowingAlert) {
                    Button(alertEntity.positiveTitle, role: .cancel) { }
                    Button(alertEntity.negativeTitle) { alertEntity.buttonAction() }
                } message: {
                    Text(alertEntity.message)
                }
        case .doubleButtonDestructive:
            content
                .alert(alertEntity.title, isPresented: $alertEntity.isShowingAlert) {
                    Button(alertEntity.positiveTitle) { }
                    Button(alertEntity.negativeTitle, role: .destructive) { alertEntity.buttonAction() }
                } message: {
                    Text(alertEntity.message)
                }
        }
    }
    
}

