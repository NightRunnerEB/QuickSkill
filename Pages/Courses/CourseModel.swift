//
//  CourseModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 27.02.2024.
//

import Foundation

// Модель для курса
struct Course: Identifiable, Codable {
    let id: Int
    var status: String
    var media: String
    var name: String
    var focus: String
    var description: String
    var durationMonth: String
    var difficultyLevel: Int
    var progress: Int = 0
    var cost: Double
    let joined: Bool
}
