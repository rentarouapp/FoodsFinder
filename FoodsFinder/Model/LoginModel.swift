//
//  LoginModel.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/30.
//

import Foundation
import FirebaseAuth
import FirebaseCore

class LoginModel {
    
    static let shared = LoginModel()
    private init() {}
    
    private let auth = Auth.auth()
    
    
}
