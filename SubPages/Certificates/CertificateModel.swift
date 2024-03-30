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
