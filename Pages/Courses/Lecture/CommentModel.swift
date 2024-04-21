//
//  CommentModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 27.02.2024.
//

import Foundation

// Модель для комментария
struct Comment: Identifiable, Codable {
    var id = UUID()
    var description: String
    var authorLogin: String
    var likes: Int
}
