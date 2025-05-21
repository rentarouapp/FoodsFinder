//
//  LoginViewModel.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/30.
//

import Foundation
import FirebaseCore
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    
    // Fetch State
    @Published var isFetching: Bool = false
    // Alert
    @Published var alertViewModel = AlertViewModel()
    // アラートが閉じられたとき
    var alertCompletion: () -> Void = { }
    
    private init() {}
    static let shared = LoginViewModel()
    
    private var loginModel = LoginModel.shared
    
    /// 新規登録
    func createUser(email: String, password: String, name: String) {
        isFetching = true
        loginModel.auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }
            self.isFetching = false
            if let error = error as NSError?,
               let errorCode = AuthErrorCode.Code(rawValue: error._code) {
                
                var errorMessage = ""
                
                switch errorCode {
                case .invalidEmail:
                    //メールアドレスの形式によるエラー
                    print("signup_mail_error")
                    errorMessage = "signup_mail_error"
                case .weakPassword:
                    //パスワードが脆弱(6文字以下)
                    print("signup_pass_error")
                    errorMessage = "signup_pass_error"
                case .emailAlreadyInUse:
                    //メールアドレスが既に登録されている
                    print("signup_already_error")
                    errorMessage = "signup_already_error"
                case .networkError:
                    //通信エラー
                    print("signup_network_error")
                    errorMessage = "signup_network_error"
                default:
                    //その他エラー
                    print("signup_other_error")
                    errorMessage = "signup_other_error"
                }
                let alertEntity = AlertService.createdUserErrorAlertEntityWithMessage(errorMessage)
                self.alertViewModel.alertEntity = alertEntity
                self.alertViewModel.alertEntity.show()
                return
            }
            let alertEntity = AlertService.createdUserAlertEntity({
                self.alertCompletion()
            })
            self.alertViewModel.alertEntity = alertEntity
            self.alertViewModel.alertEntity.show()
        }
    }
    
    /// サインイン
    func signIn(email: String, password: String) {
        loginModel.auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let _ = self else { return }
            if let _ = result?.user {
                // ログイン成功
            } else {
                // ログイン失敗
            }
        }
    }
    
    /// サインアウト
    func signOut() {
        do {
            try loginModel.auth.signOut()
        } catch {
            // サインアウト失敗
        }
    }
    
    /// 退会
    func withdrawal(password: String) {
        if let user = loginModel.currentUser() {
            user.delete() { [weak self] error in
                guard let _ = self else { return }
                if let _ = error {
                    // 退会失敗
                } else {
                    // 退会成功
                }
            }
        }
    }
    
    /// パスワードのリセット
    func resetPassWord(email: String) {
        loginModel.auth.sendPasswordReset(withEmail: email) { [weak self] error in
            guard let _ = self else { return }
            if let _ = error {
                // パスワードのリセット失敗
            } else {
                // パスワードのリセット成功
            }
        }
    }
    
}

