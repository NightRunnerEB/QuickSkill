//
//  Topic.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.03.2024.
//

import Foundation

struct Topic: Identifiable, Decodable {
    let id: Int
    let name: String
    var content: [Lesson]
    var blocked: Bool
    
    static var topics: [Topic] = [
        Topic(id: 0, name: "Introduction to C#", content: [
            Lesson(id: 0, name: "Getting Started with C#", description: "Setting up the environment and writing your first C# program.", type: .lecture, blocked: false),
            Lesson(id: 1, name: "Basic Syntax", description: "Understanding syntax and structure of C# programs.", type: .practice, blocked: true)
        ], blocked: false),
        
        Topic(id: 1, name: "Control Structures", content: [
            Lesson(id: 0, name: "Decision Making", description: "Learn how to use conditional statements.", type: .lecture, blocked: false),
            Lesson(id: 1, name: "Loop Constructs", description: "Understanding loops in C#.", type: .practice, blocked: true)
        ], blocked: true),
        
        Topic(id: 2, name: "Object-Oriented Programming", content: [
            Lesson(id: 0, name: "Classes and Objects", description: "Dive into classes, objects, and methods.", type: .lecture, blocked: false),
            Lesson(id: 1, name: "Inheritance and Polymorphism", description: "Exploring the principles of OOP.", type: .practice, blocked: true)
        ], blocked: true),
        
        Topic(id: 3, name: "Data Management", content: [
            Lesson(id: 0, name: "Working with Collections", description: "Managing data with generics and collections.", type: .lecture, blocked: false),
            Lesson(id: 1, name: "File I/O", description: "Reading and writing to files.", type: .practice, blocked: true)
        ], blocked: true),
        
        Topic(id: 4, name: "Advanced C#", content: [
            Lesson(id: 0, name: "Delegates and Events", description: "Understanding advanced C# features.", type: .lecture, blocked: false),
            Lesson(id: 1, name: "LINQ Queries", description: "Learning Language Integrated Query (LINQ).", type: .practice, blocked: true)
        ], blocked: true),
        
        Topic(id: 5, name: "Asynchronous Programming", content: [
            Lesson(id: 0, name: "Asynchronous and Parallel Programming", description: "Writing asynchronous C# code.", type: .lecture, blocked: false),
            Lesson(id: 1, name: "Task Parallel Library", description: "Using TPL for multithreading.", type: .practice, blocked: true)
        ], blocked: true),
        
        Topic(id: 6, name: "Deploying C# Applications", content: [
            Lesson(id: 0, name: "Debugging and Diagnostics", description: "Finding and fixing issues in C# applications.", type: .lecture, blocked: false),
            Lesson(id: 1, name: "Deployment Strategies", description: "Deploying applications to production.", type: .practice, blocked: true)
        ], blocked: true)
    ]
}
