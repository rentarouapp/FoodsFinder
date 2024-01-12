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
    
    @Published var error: NSError?
    
    private init() {}
    static let shared = LoginViewModel()
    
    private var loginModel = LoginModel.shared
    
    /// 新規登録
    func createUser(email: String, password: String, name: String) {
        loginModel.auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }
            if let user = result?.user {
                let request = user.createProfileChangeRequest()
                request.displayName = name
                request.commitChanges() { [weak self] error in
                    if error == nil {
                        // 仮登録が完了したよ
                        print("仮登録完了画面へ")
                    }
                }
            }
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

