//
//  Notifications.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 01.04.2024.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    // Запрос разрешения на отправку уведомлений
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.providesAppNotificationSettings, .sound, .badge]) { granted, error in
            if let error = error {
                print("Ошибка при запросе разрешения уведомлений: \(error)")
            }
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    // Отправка локального уведомления
    func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        // Установка триггера уведомления, чтобы оно отобразилось сразу
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        // Создание запроса на уведомление
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // Добавление запроса в центр уведомлений
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error)")
            }
        }
    }
}

