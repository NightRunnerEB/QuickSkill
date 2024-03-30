//
//  DailyTasksView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.02.2024.
//

import Foundation

struct DailyTask: Identifiable, Codable {
    var id: Int
    let icon: String
    let description: String
    let targetValue: Int
    var currentValue: Int = 0
    
    var isCompleted: Bool {
        currentValue >= targetValue
    }
}
