//
//  LeagueModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 21.02.2024.
//

import Foundation
import SwiftUI

struct League: Identifiable, Decodable {
    let id: Int
    let name: String
    let leagueImage: String
}

extension League {
    static let solarSentinel = League(id: 0, name: "Solar Sentinel", leagueImage: "Solar Sentinel")
    static let aquaHorizon = League(id: 1, name: "Aqua Horizon", leagueImage: "Aqua Horizon")
    static let cyberShield = League(id: 2, name: "Cyber Shield", leagueImage: "Cyber Shield")
    static let digitalGuardian = League(id: 3, name: "Digital Guardian", leagueImage: "Digital Guardian")
    static let dataSentinel = League(id: 4, name: "Data Sentinel", leagueImage: "Data Sentinel")
    static let codeProtector = League(id: 5, name: "Code Protector", leagueImage: "Code Protector")
    static let quantumGuardian = League(id: 6, name: "Quantum Guardian", leagueImage: "Quantum Guardian")
    static let binarySentinel = League(id: 7, name: "Binary Sentinel", leagueImage: "Binary Sentinel")
    static let techDefender = League(id: 8, name: "Tech Defender", leagueImage: "Tech Defender")
}

extension League {
    static let leagues: [League] = [
        .solarSentinel,
        .aquaHorizon,
        .cyberShield,
        .digitalGuardian,
        .dataSentinel,
        .codeProtector,
        .quantumGuardian,
        .binarySentinel,
        .techDefender
    ]
}


