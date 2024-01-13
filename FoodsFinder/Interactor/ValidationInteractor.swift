//
//  ValidationInteractor.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import Foundation

class ValidationInteractor {
    
    // 登録時のバリデーションを実行し問題があるときだけAlertEntityを返す
    static func singleButtonAlertEntityWithSignUpValidation(email: String, password: String, confirmPassword: String) -> CustomAlertEntity? {
        
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            // いずれか空文字
            return alertEntityWithMessage("・メールアドレス\n・パスワード\n・確認用パスワード\n\nは必須項目です。")
        }
        if password != confirmPassword {
            return alertEntityWithMessage("パスワードと確認用パスワードの内容が違います。")
        }
        if password.count < 3 {
            return alertEntityWithMessage("パスワードは3文字以上でお願いします。")
        }
        if isValidEmail(email) == false {
            // メールアドレスの形式が不正
            return alertEntityWithMessage("メールアドレスの形式が不正です。")
        }
        return nil
    }
    
    static func alertEntityWithMessage(_ message: String) -> CustomAlertEntity {
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
 
    static func isValidEmail(_ string: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: string)
        return result
    }
}
