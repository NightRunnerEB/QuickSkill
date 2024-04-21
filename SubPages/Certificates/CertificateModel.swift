//
//  CertificateModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.02.2024.
//

import Foundation

struct Certificate: Identifiable, Codable {
    let id: Int
    let name: String
    let media: String
    let description: String
}

extension Certificate {
    static let certificates = [
        Certificate(id: 1, name: "Web Development", media: "C++_icon", description: "Learn full stack web development."),
        Certificate(id: 2, name: "Data Science", media: "C#_icon", description: "Master the fundamentals of data analysis."),
        Certificate(id: 3, name: "AI and Machine Learning", media: "C++_icon", description: "Dive into the world of artificial intelligence.")
    ]
}
