//
//  GoalModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 23.02.2024.
//

import Foundation

class Goal: Codable {
    var reminder = true
    var duraction: Double
    var description: String
    
    init(reminder: Bool = true, duraction: Double, description: String) {
        self.reminder = reminder
        self.duraction = duraction
        self.description = description
    }
}
