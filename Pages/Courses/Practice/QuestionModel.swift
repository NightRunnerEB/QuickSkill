//
//  QuestionModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 27.02.2024.
//

import Foundation

// Модель для задания
struct Question: Identifiable, Codable {
    var id: Int
    var text: String
    var answers: [String]
    var correctAnswer: Int
    
    // Эта функция проверяет, правильный ли дан ответ
    func isAnswerCorrect(_ answer: Int) -> Bool {
        return answer == correctAnswer
    }
}
