//
//  CourseModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 27.02.2024.
//

import Foundation

// Модель для курса
class Course: Identifiable, Decodable {
    let id: Int
    var status: String
    var media: String
    var name: String
    var focus: String
    var description: String
    var durationMonth: String
    var difficultyLevel: Int
    var progress: Int
    var cost: Double
    let joined: Bool

    // Инициализатор для создания объектов Course
    init(id: Int, status: String, media: String, name: String, focus: String, description: String, durationMonth: String, difficultyLevel: Int, progress: Int, cost: Double, joined: Bool) {
        self.id = id
        self.status = status
        self.media = media
        self.name = name
        self.focus = focus
        self.description = description
        self.durationMonth = durationMonth
        self.difficultyLevel = difficultyLevel
        self.progress = progress
        self.cost = cost
        self.joined = joined
    }

    // Статическая переменная для хранения списка курсов
    static var courses: [Course] = [
        Course(id: 101, status: "Active", media: "C++_icon", name: "Intro to C++", focus: "C++ Development", description: "Learn the basics of C++", durationMonth: "3 months", difficultyLevel: 2, progress: 0, cost: 99.99, joined: true),
        Course(id: 102, status: "Active", media: "C#_icon", name: "Advanced C#", focus: "Software Development", description: "Dive deep into C# language features", durationMonth: "4 months", difficultyLevel: 3, progress: 0, cost: 149.99, joined: false),
        Course(id: 103, status: "Active", media: "C++_icon", name: "C++ Design Patterns", focus: "Design Principles", description: "Explore design patterns used in C++", durationMonth: "2 months", difficultyLevel: 4, progress: 75, cost: 199.99, joined: true),
        Course(id: 104, status: "Active", media: "C#_icon", name: "Data Structures and Algorithms in C#", focus: "Computer Science", description: "Understand data structures for better coding", durationMonth: "6 months", difficultyLevel: 5, progress: 0, cost: 299.99, joined: false)
    ]
}

