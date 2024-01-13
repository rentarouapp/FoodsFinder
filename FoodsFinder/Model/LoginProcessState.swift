//
//  LoginProcessState.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import Foundation

class LoginProcessState {
    var isFetching: Bool = false // 実行中か
    var isSucceed: Bool = false // それぞれの動作が成功したとき
    var alertViewModel = AlertViewModel()
}
