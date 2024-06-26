//
//  NotificationManager.swift
//  MuscleRecording
//
//  Created by 千千 on 6/26/24.
//

import Foundation
import UserNotifications
class NotificationManager {
    static let shared = NotificationManager()
    init() {
        
    }
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("请求通知权限出错：\(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    func scheduleNotification(at date: Date, _ completion: @escaping (Bool) -> Void) {
        let content = UNMutableNotificationContent()
        content.title = "提醒"
        content.body = "这是您设置的提醒。"
        content.sound = UNNotificationSound.default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                DispatchQueue.main.sync {
                    completion(false)
                }
                print("计划通知出错：\(error.localizedDescription)")
            } else {
                DispatchQueue.main.sync {
                    completion(true)
                }
            }
        }
    }
}
