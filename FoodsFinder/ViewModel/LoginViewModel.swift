//
//  LoginViewModel.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/30.
//

import Foundation
import FirebaseCore
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    static let shared = LoginViewModel()
    private init() {}
    
    private var loginModel = LoginModel.shared
    
    
}

