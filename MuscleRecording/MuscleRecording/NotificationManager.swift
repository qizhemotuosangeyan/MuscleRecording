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
    private let notificationIdentifier = "muscleRecordingReminder" //标识一下通知确保某个时间点只有一个通知
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
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
        let content = UNMutableNotificationContent()
        content.title = "是时候记录一下现在的肌肉维度啦"
        content.body = "到了上次您设置的肌肉记录提醒时间啦，带着软尺进来重新量一下数据吧～"
        content.sound = UNNotificationSound.default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        
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
    func checkNotificationExists(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            let exists = requests.contains { $0.identifier == self.notificationIdentifier }
            DispatchQueue.main.async {
                completion(exists)
            }
        }
    }
}
