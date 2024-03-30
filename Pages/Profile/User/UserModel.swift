//
//  User.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 19.02.2024.
//

import Foundation

class User: ObservableObject, Codable {
    @Published var firstName: String
    @Published var lastName: String
    @Published var username: String
    @Published var xp: Int
    @Published var userLevel: Int
    @Published var streak: Int
    @Published var description: String
    @Published var email: String
    @Published var photo: String
    @Published var energy: Int
    @Published var crystalls: Int
    @Published var streakSavers: Int
    @Published var streakRecord: Int
    @Published var followers: Int
    @Published var followings: Int
    @Published var goalText: String
    @Published var goalDay: Int
    @Published var status: String

    enum CodingKeys: CodingKey {
        case firstName, lastName, username, xp, userLevel, streak, description, email, photo, energy, crystalls, streakSavers, streakRecord, followers, followings, goalText, goalDay, status
    }

    init(firstName: String, lastName: String, username: String, xp: Int, userLevel: Int, streak: Int, description: String, email: String, photo: String, energy: Int, crystalls: Int, streakSavers: Int, streakRecord: Int, followers: Int, followings: Int, goalText: String, goalDay: Int, status: String) {
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
        self.crystalls = crystalls
        self.streakSavers = streakSavers
        self.streakRecord = streakRecord
        self.followers = followers
        self.followings = followings
        self.goalText = goalText
        self.goalDay = goalDay
        self.status = status
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _firstName = Published(initialValue: try container.decode(String.self, forKey: .firstName))
        _lastName = Published(initialValue: try container.decode(String.self, forKey: .lastName))
        _username = Published(initialValue: try container.decode(String.self, forKey: .username))
        _xp = Published(initialValue: try container.decode(Int.self, forKey: .xp))
        _userLevel = Published(initialValue: try container.decode(Int.self, forKey: .userLevel))
        _streak = Published(initialValue: try container.decode(Int.self, forKey: .streak))
        _description = Published(initialValue: try container.decode(String.self, forKey: .description))
        _email = Published(initialValue: try container.decode(String.self, forKey: .email))
        _photo = Published(initialValue: try container.decode(String.self, forKey: .photo))
        _energy = Published(initialValue: try container.decode(Int.self, forKey: .energy))
        _crystalls = Published(initialValue: try container.decode(Int.self, forKey: .crystalls))
        _streakSavers = Published(initialValue: try container.decode(Int.self, forKey: .streakSavers))
        _streakRecord = Published(initialValue: try container.decode(Int.self, forKey: .streakRecord))
        _followers = Published(initialValue: try container.decode(Int.self, forKey: .followers))
        _followings = Published(initialValue: try container.decode(Int.self, forKey: .followings))
        _goalText = Published(initialValue: try container.decode(String.self, forKey: .goalText))
        _goalDay = Published(initialValue: try container.decode(Int.self, forKey: .goalDay))
        _status = Published(initialValue: try container.decode(String.self, forKey: .status))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(username, forKey: .username)
        try container.encode(xp, forKey: .xp)
        try container.encode(userLevel, forKey: .userLevel)
        try container.encode(streak, forKey: .streak)
        try container.encode(description, forKey: .description)
        try container.encode(email, forKey: .email)
        try container.encode(photo, forKey: .photo)
        try container.encode(energy, forKey: .energy)
        try container.encode(crystalls, forKey: .crystalls)
        try container.encode(streakSavers, forKey: .streakSavers)
        try container.encode(streakRecord, forKey: .streakRecord)
        try container.encode(followers, forKey: .followers)
        try container.encode(followings, forKey: .followings)
        try container.encode(goalText, forKey: .goalText)
        try container.encode(goalDay, forKey: .goalDay)
        try container.encode(status, forKey: .status)
    }
}
