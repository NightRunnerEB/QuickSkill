//
//  Topic.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.03.2024.
//

import Foundation

struct Topic: Identifiable, Codable {
    let id: Int
    let name: Int
    let content: [Lesson]
}
