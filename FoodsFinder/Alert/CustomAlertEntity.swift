//
//  CustomAlertEntity.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import Foundation

struct CustomAlertEntity {
    
    enum ButtonType {
        case singleButton
        case doubleButton
        case doubleButtonDestructive
    }
    
    var isShowingAlert: Bool = false
    var buttonType: ButtonType = .singleButton
    var title: String = ""
    var message: String = ""
    var positiveTitle: String = ""
    var negativeTitle: String = ""
    var buttonAction: () -> Void = {}
    
    mutating func show(buttonType: ButtonType,
                       title: String,
                       message: String,
                       positiveTitle: String = "",
                       negativeTitle: String,
                       buttonAction: @escaping () -> Void = {}) {
        
        self.buttonType = buttonType
        self.title = title
        self.message = message
        self.positiveTitle = positiveTitle
        self.negativeTitle = negativeTitle
        self.buttonAction = buttonAction
        self.isShowingAlert = true
    }
    
    mutating func hide() {
        self.isShowingAlert = false
    }
    
}

