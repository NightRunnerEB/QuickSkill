//
//  QuickSkillApp.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 10.02.2024.
//

import SwiftUI

@main
struct QuickSkillApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var userVM = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userVM)
        }
    }
}
