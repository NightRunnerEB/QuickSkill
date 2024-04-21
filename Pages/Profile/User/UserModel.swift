//
//  User.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 19.02.2024.
//

import Foundation

class User: ObservableObject, Decodable {
    @Published var firstName: String
    @Published var lastName: String
    @Published var username: String
    @Published var xp: Int
    @Published var userlevel: Int
    @Published var streak: Int
    @Published var maxStreak: Int
    @Published var description: String
    @Published var photo: String?
    @Published var goalText: String
    @Published var goalDay: Double
    @Published var status: String
    @Published var freezer: Int
    @Published var hearts: Int
    @Published var crystall: Int
    
    private enum CodingKeys: String, CodingKey {
        case firstname, lastname, username, xp, userlevel, streak, maxStreak, description, photo, goalText, goalDay, status, freezer, hearts, crystall
    }
    
    // Свойства будут инициализированы ниже в init(from:) при декодировании
    init(firstName: String, lastName: String, username: String, xp: Int, userlevel: Int, streak: Int, maxStreak: Int, description: String, photo: String?, goalText: String, goalDay: Double, status: String, freezer: Int, hearts: Int, crystall: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.xp = xp
        self.userlevel = userlevel
        self.streak = streak
        self.maxStreak = maxStreak
        self.description = description
        self.photo = photo
        self.goalText = goalText
        self.goalDay = goalDay
        self.status = status
        self.freezer = freezer
        self.hearts = hearts
        self.crystall = crystall
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _firstName = Published(initialValue: try container.decode(String.self, forKey: .firstname))
        _lastName = Published(initialValue: try container.decode(String.self, forKey: .lastname))
        _username = Published(initialValue: try container.decode(String.self, forKey: .username))
        _xp = Published(initialValue: try container.decode(Int.self, forKey: .xp))
        _userlevel = Published(initialValue: try container.decode(Int.self, forKey: .userlevel))
        _streak = Published(initialValue: try container.decode(Int.self, forKey: .streak))
        _maxStreak = Published(initialValue: try container.decode(Int.self, forKey: .maxStreak))
        _description = Published(initialValue: try container.decodeIfPresent(String.self, forKey: .description) ?? "")
        _photo = Published(initialValue: try container.decodeIfPresent(String.self, forKey: .photo))
        _goalText = Published(initialValue: try container.decodeIfPresent(String.self, forKey: .goalText) ?? "")
        _goalDay = Published(initialValue: try container.decodeIfPresent(Double.self, forKey: .goalDay) ?? 0)
        _status = Published(initialValue: try container.decode(String.self, forKey: .status))
        _freezer = Published(initialValue: try container.decode(Int.self, forKey: .freezer))
        _hearts = Published(initialValue: try container.decode(Int.self, forKey: .hearts))
        _crystall = Published(initialValue: try container.decode(Int.self, forKey: .crystall))
    }
}
