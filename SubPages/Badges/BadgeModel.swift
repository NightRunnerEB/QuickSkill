//
//  BadgeModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 27.02.2024.
//

import Foundation

struct Badge: Identifiable, Decodable {
    var id: Int
    var name: String
    var progress: Int = 0
    var required: Int
    var achieved: Bool
    var taskToAchieve: String
    var photo: String
    var grayPhoto: String = "Badge3"
}

extension Badge {
    static let quickSkillVeteran = Badge(id: 1, name: "Quick Skill Veteran", required: 10, achieved: true, taskToAchieve: "For successful service in the ranks of the Quick Skill digital troops", photo: "Badge1")
    static let practiceKiller = Badge(id: 2, name: "Practice killer", required: 10, achieved: true, taskToAchieve: "Systematic and persistent training for 3 months in a row to improve your programming skills", photo: "Badge2")
    static let answerGuru = Badge(id: 3, name: "Answer guru👽", required: 10, achieved: true, taskToAchieve: "Demonstrating a high level of knowledge and expertise in answering questions and tasks related to programming", photo: "Badge3")
    static let some4 = Badge(id: 4, name: "Master C++💀", required: 10, achieved: false, taskToAchieve: "Complete all C++ courses", photo: "Badge")
    static let some5 = Badge(id: 5, name: "Master C#🌈", required: 10, achieved: false, taskToAchieve: "Complete all C# courses", photo: "Badge")
    static let some6 = Badge(id: 6, name: "Master Swift💪", required: 10, achieved: false, taskToAchieve: "Complete all Swift courses", photo: "Badge")
}

extension Badge {
    static let sampleData: [Badge] = [
        .quickSkillVeteran,
        .practiceKiller,
        .answerGuru,
        .some4,
        .some5,
        .some6
    ]
}
