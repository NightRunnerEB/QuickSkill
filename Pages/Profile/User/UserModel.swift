//
//  User.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 19.02.2024.
//

import Foundation
import SwiftUI

class User: Codable {
    
    var email: String
    var firstName: String
    var lastName: String
    
    //возможно тоже лишнее
    var password: String
    
    //воозможно хранить эти списки не нужно, а просто обращаться к бд по токену
    var followers: [User]
    var following: [User]

    var avatarImageUrl: String
    var goal: Goal
    var experience: Int
    var hearts: Int
    var energy: Int
    var crystalls: Int
    var streakSavers: Int
    var streak: Int
    var streakRecord: Int
    var coursesSuccess: [Int: Int] // key - id курса, value - текущий уровень
    var badges : [Int]
    var certificates : [Int]
    var ratingLeague : [User]
    private var _uniqueLogin: String?
    
    var uniqueLogin: String {
        get {
            if _uniqueLogin == nil {
                let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
                _uniqueLogin = "@" + String((0..<7).compactMap{ _ in characters.randomElement() })
            }
            return _uniqueLogin!
        }
        set {
            _uniqueLogin = newValue
        }
    }
    var bio: String
    
    init(email: String, firstName: String, lastName: String, password: String, avatarImageUrl: String, bio: String = "") {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.followers = []
        self.following = []
        self.avatarImageUrl = avatarImageUrl
        self.experience = 3400
        self.bio = bio
        self.coursesSuccess = [1:2]
//        self.uniqueLogin = ""
        self.hearts = 5
        self.crystalls = 3300
        self.streakSavers = 1
        self.streak = 8
        self.energy = 5
        self.badges = [1, 2, 3]
        self.certificates = [1, 2, 3, 4]
        self.streakRecord = 73
        self.goal = Goal(duraction: 6, description: "To be the best!")

        self.ratingLeague = []
    }
}
