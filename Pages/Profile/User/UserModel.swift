//
//  User.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 19.02.2024.
//

import Foundation

class User: ObservableObject, Decodable {
    var firstName: String
    var lastName: String
    var username: String
    var xp: Int
    var userLevel: Int
    var streak: Int
    var description: String
    var email: String
    var photo: String
    var energy: Int
    var crystals: Int
    var streakSavers: Int
    var streakRecord: Int
    var followers: Int
    var followings: Int
    var goalText: String
    var goalDay: Double
    var status: String

    init(firstName: String, lastName: String, username: String, xp: Int, userLevel: Int, streak: Int, description: String, email: String, photo: String, energy: Int, crystals: Int, streakSavers: Int, streakRecord: Int, followers: Int, followings: Int, goalText: String, goalDay: Double, status: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.xp = xp
        self.userLevel = userLevel
        self.streak = streak
        self.description = description
        self.email = email
        self.photo = photo
        self.energy = energy
        self.crystals = crystals
        self.streakSavers = streakSavers
        self.streakRecord = streakRecord
        self.followers = followers
        self.followings = followings
        self.goalText = goalText
        self.goalDay = goalDay
        self.status = status
    }
}
