//
//  NavigationPath.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import SwiftUI

enum ViewPath: Int{
    case hp, login, signup
    
    var toString: String {
        ["ホットペッパー", "ログイン", "サインアップ"][self.rawValue]
    }
    
    @ViewBuilder
    func Destination() -> some View{
        switch self {
        case .hp: HPView()
        case .login: LoginView()
        case .signup: SignUpView()
        }
    }
}
