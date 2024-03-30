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
    var progress: Int
    var required: Int
    var achieved: Bool
    var taskToAchieve: String
    var photo: String
    var grayPhoto: String
}
