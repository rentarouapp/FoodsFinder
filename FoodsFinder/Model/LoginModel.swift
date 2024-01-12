//
//  LoginModel.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/30.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import AuthenticationServices
import SwiftUI

class LoginModel {
    
    private init() {}
    
    static let shared = LoginModel()
    let auth = Auth.auth()
    
    let defaultName = "ゲスト"
    
    public func currentUser() -> User? {
        return auth.currentUser
    }
    
}
