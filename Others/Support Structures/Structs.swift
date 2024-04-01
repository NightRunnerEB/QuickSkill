//
//  Structs.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 15.03.2024.
//

import Foundation

struct RegistrationData: Encodable {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
}

struct LoginData: Encodable {
    var email: String
    var password: String
}

struct AuthResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
