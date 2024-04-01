//
//  AppDelegate.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 01.04.2024.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Установка делегата центра уведомлений
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // Обработка уведомлений в переднем плане
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound]) // Показать уведомление даже если приложение в переднем плане
    }
}
