//
//  AppleHero.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/06/02.
//

import Foundation

enum AppleHero {
    case tim
    case crag
    case john
    case jony
    case jobs
    
    var name: String {
        switch self {
        case .tim:
            return "Tim Cook"
        case .crag:
            return "Craig Federighi"
        case .john:
            return "John Ternus"
        case .jony:
            return "Jonathan Ive"
        case .jobs:
            return "Steve Jobs"
        }
    }
    
    var imageName: String {
        switch self {
        case .tim:
            return "tcook"
        case .crag:
            return "craig"
        case .john:
            return "john"
        case .jony:
            return "jony"
        case .jobs:
            return "jobs"
        }
    }
    
    var description: String {
        switch self {
        case .tim:
            return "Tim Cook"
        case .crag:
            return "Craig Federighi"
        case .john:
            return "John Ternus"
        case .jony:
            return "Jonathan Ive"
        case .jobs:
            return "Steve Jobs"
        }
    }
}
