//
//  AlertService.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/14.
//

import Foundation

class AlertService {
    
    // 新規登録時入力バリデーションのAlertEntityを返す
    static func inputValidationAlertEntityWithMessage(_ message: String) -> CustomAlertEntity {
        let alertEntity = CustomAlertEntity(
            buttonType: .singleButton,
            title: "入力エラー",
            message: message,
            positiveTitle: "",
            negativeTitle: "閉じる",
            buttonAction: {}
        )
        return alertEntity
    }
    
    // 仮登録完了時のAlertEntityを返す
    static func createdUserAlertEntity(_ action: @escaping () -> Void) -> CustomAlertEntity {
        let alertEntity = CustomAlertEntity(
            buttonType: .singleButton,
            title: "会員登録完了",
            message: "会員登録完了しました！ログインして使ってね！",
            positiveTitle: "",
            negativeTitle: "閉じる",
            buttonAction: action
        )
        return alertEntity
    }
    
    // 登録エラーのAlertEntityを返す
    static func createdUserErrorAlertEntityWithMessage(_ message: String) -> CustomAlertEntity {
        let alertEntity = CustomAlertEntity(
            buttonType: .singleButton,
            title: "エラー",
            message: message,
            positiveTitle: "",
            negativeTitle: "閉じる",
            buttonAction: {}
        )
        return alertEntity
    }
    
}
