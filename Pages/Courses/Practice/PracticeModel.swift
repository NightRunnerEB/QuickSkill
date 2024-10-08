//
//  PracticeModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 27.02.2024.
//

import Foundation

// Модель для практического занятия
struct Practice: Identifiable, Decodable {
    var id = UUID()
    var title: String
    var description: String
    var numberOfCorrectAnswers: Int
}
