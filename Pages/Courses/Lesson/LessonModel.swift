//
//  LessonModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.03.2024.
//

import Foundation

struct Lesson: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let type: String
}
