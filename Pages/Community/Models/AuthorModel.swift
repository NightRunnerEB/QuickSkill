//
//  author.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 28.03.2024.
//

import Foundation

struct Author: Identifiable, Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let status: String
    let username: String
    let photo: String?
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

