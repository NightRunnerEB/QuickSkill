//
//  QuestionModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 27.02.2024.
//

import Foundation

// Модель для задания
struct Task: Identifiable, Codable {
    var id = UUID()
    var questionDescription: String
    var answerOptions: [String]
    var correctAnswerIndex: Int
}
