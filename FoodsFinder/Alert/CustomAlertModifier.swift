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
        content
            .alert(isPresented: $alertEntity.isShowingAlert) {
                switch alertEntity.buttonType {
                case .singleButton:
                    return Alert(title: Text(alertEntity.title),
                                 message: Text(alertEntity.message),
                                 dismissButton: .default(Text(alertEntity.negativeTitle), action: { alertEntity.buttonAction() })
                    )
                    
                case .doubleButton:
                    return Alert(title: Text(alertEntity.title),
                                 message: Text(alertEntity.message),
                                 primaryButton: .cancel(Text(alertEntity.positiveTitle)),
                                 secondaryButton: .default(Text(alertEntity.negativeTitle), action: { alertEntity.buttonAction() })
                    )
                case .doubleButtonDestructive:
                    return Alert(title: Text(alertEntity.title),
                                 message: Text(alertEntity.message),
                                 primaryButton: .default(Text(alertEntity.positiveTitle)),
                                 secondaryButton: .destructive(Text(alertEntity.negativeTitle), action: { alertEntity.buttonAction() })
                    )
                }
            }
    }
    
}

