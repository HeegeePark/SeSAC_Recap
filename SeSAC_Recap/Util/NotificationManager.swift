//
//  NotificationManager.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/25/24.
//

import UIKit
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() { }
    
    // Notification 권한 설정
    func setAuthorization() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isSuccess, error in
            if let error {
                print("")
                print("===============================")
                print("[AppDelegate >> requestAuthorization() :: 노티피케이션 권한 요청 에러]")
                print("[error :: \(error.localizedDescription)]")
                print("===============================")
                print("")
            } else {
                print("")
                print("===============================")
                print("[AppDelegate >> requestAuthorization() :: 노티피케이션 권한 요청 응답 확인]")
                print("[isSuccess :: \(isSuccess)]")
                print("===============================")
                print("")
            }
        }
    }
    
    func pushNotification(title: String, body: String, seconds: Double, repeats: Bool, identifier: String) {
        // 알림 내용, 설정
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        notificationContent.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
        
        // 조건(시간, 반복)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: repeats)
        
        let request = UNNotificationRequest(identifier: identifier,
                                            content: notificationContent,
                                            trigger: trigger)
        
        // 등록
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
