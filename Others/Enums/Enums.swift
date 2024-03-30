//
//  Enums.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.03.2024.
//

import Foundation

enum SkillLevel: String, CaseIterable, Identifiable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    
    var id: Int {
        switch self {
        case .beginner:
            return 1
        case .intermediate:
            return 2
        case .advanced:
            return 3
        }
    }
}

enum TimeFrame: String, CaseIterable, Identifiable {
    case oneMonth = "< 1 month"
    case twoThreeMonths = "2-3 months"
    case threePlusMonths = "3+ months"
    
    var id: Int {
        switch self {
        case .oneMonth:
            return 1
        case .twoThreeMonths:
            return 2
        case .threePlusMonths:
            return 3
        }
    }
}

enum CostOption: String, CaseIterable, Identifiable {
    case free, paid
    
    var id: Bool {
        switch self {
        case .free:
            return true
        case .paid:
            return false
        }
    }
}
