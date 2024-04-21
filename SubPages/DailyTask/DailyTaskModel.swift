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
    
    static let sampleData: [DailyTask] = [
        DailyTask(id: 1, icon: "Task_5", description: "Read 3 topics", targetValue: 3),
        DailyTask(id: 2, icon: "Task_5", description: "Log in to the app", targetValue: 1),
        DailyTask(id: 3, icon: "Task_10", description: "Complete 5 lessons", targetValue: 5)
    ]
}
