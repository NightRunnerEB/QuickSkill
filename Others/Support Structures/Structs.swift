//
//  Structs.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 15.03.2024.
//

import Foundation

struct RegistrationData: Encodable {
    var firstname: String
    var lastname: String
    var email: String
    var password: String
}

struct LoginData: Encodable {
    var email: String
    var password: String
}

struct AuthResponse: Encodable {
    let accessToken: String
    let refreshToken: String
}
