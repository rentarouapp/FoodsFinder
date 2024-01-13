//
//  AlertViewModel.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/01/13.
//

import Foundation

class AlertViewModel: ObservableObject {
    @Published var alertEntity = CustomAlertEntity(
        buttonType: .singleButton,
        title: "",
        message: "",
        positiveTitle: "",
        negativeTitle: "",
        buttonAction: {}
    )
}
