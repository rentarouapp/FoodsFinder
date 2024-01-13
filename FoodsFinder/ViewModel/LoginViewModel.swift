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
    
    @Published var loginProcessState = LoginProcessState()
    
    private init() {}
    static let shared = LoginViewModel()
    
    private var loginModel = LoginModel.shared
    
    /// 新規登録
    func createUser(email: String, password: String, name: String) {
        loginProcessState.isFetching = true
        loginModel.auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }
            self.loginProcessState.isFetching = false
            if let error = error as NSError?,
               let errorCode = AuthErrorCode.Code(rawValue: error._code) {
                switch errorCode {
                case .invalidEmail:
                    //メールアドレスの形式によるエラー
                    print("signup_mail_error")
                case .weakPassword:
                    //パスワードが脆弱(6文字以下)
                    print("signup_pass_error")
                case .emailAlreadyInUse:
                    //メールアドレスが既に登録されている
                    print("signup_already_error")
                case .networkError:
                    //通信エラー
                    print("signup_network_error")
                default:
                    //その他エラー
                    print("signup_other_error")
                }
                return
            }
            self.loginProcessState.isSucceed = true
            print("仮登録完了画面へ")
        }
    }
    
    /// サインイン
    func signIn(email: String, password: String) {
        loginModel.auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }
            if let user = result?.user {
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
        } catch let signOutError as NSError {
            // サインアウト失敗
        }
    }
    
    /// 退会
    func withdrawal(password: String) {
        if let user = loginModel.currentUser() {
            user.delete() { [weak self] error in
                guard let self else { return }
                if let error {
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
            guard let self else { return }
            if let error {
                // パスワードのリセット失敗
            } else {
                // パスワードのリセット成功
            }
        }
    }
    
}

