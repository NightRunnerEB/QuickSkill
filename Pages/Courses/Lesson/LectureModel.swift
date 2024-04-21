//
//  LectureModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 27.02.2024.
//

import Foundation

// Модель для лекции
struct Lecture: Identifiable, Codable {
    var id = UUID()
    var videoUrl: URL
    var title: String
    var description: String
    var comments: [Comment]
}
