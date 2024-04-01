//
//  PostModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 28.03.2024.
//

import Foundation

struct Post: Identifiable, Decodable {
    let id: Int
    let discussion: Discussion
    let author: Author
    
//    // Создание массива объектов Post
//    static let sampleData: [Post] = [
//        Post(discussion: Discussion(id: 1, title: "Understanding Swift Optionals", body: "Will i leave someday?", date: "2024/04/01", likes: 11, countAnswers: 5),
//             author: Author(id: 1, icon: "Окунь", firstName: "Aleksey", lastName: "Kiselev")),
//        Post(discussion: Discussion(id: 2, title: "Best Practices for iOS Networking", body: "Will i leave someday?", date: "2024/04/02", likes: 52, countAnswers: 23),
//             author: Author(id: 2, icon: "Окунь1", firstName: "Evgeniy", lastName: "Bukharev")),
//        Post(discussion: Discussion(id: 3, title: "Struct vs Class in Swift", body: "Will i leave someday?", date: "2024/04/03", likes: 9, countAnswers: 2),
//             author: Author(id: 3, icon: "Окунь", firstName: "Antov", lastName: "Ribak")),
//        Post(discussion: Discussion(id: 4, title: "Protocol-Oriented Programming", body: "Will i leave someday?", date: "2024/04/04", likes: 17, countAnswers: 4),
//             author: Author(id: 4, icon: "Окунь1", firstName:"Simple", lastName: "Sania")),
//        Post(discussion: Discussion(id: 5, title: "SwiftUI State Management", body: "Will i leave someday?", date: "2024/04/05", likes: 23, countAnswers: 10),
//             author: Author(id: 5, icon: "Окунь", firstName: "Seif", lastName: "Kabum"))
//    ]
}
