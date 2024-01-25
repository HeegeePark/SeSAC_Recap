//
//  AppDelegate.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // delegate 연결은 꼭 AppDelegate에서!
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // 앱이 종료되기 직전
    func applicationWillTerminate(_ application: UIApplication) {
        // keyword 활용한 쇼핑리스트 관리 push 등록
        guard let log = UserDefaultUtils.searchLogs.last else { return }
        
        let title = "🌱 \(UserDefaultUtils.user.nickname)님, 쇼핑하러 돌아와요~~"
        let message = "더 많은 '\(log.keyword)' 상품을 찾아보세요! 🛍️"
        
        NotificationManager.shared.pushNotification(title: title, body: message, seconds: 86400, repeats: true, identifier: Notification.Name.manageShoppingList.rawValue)
    }
}

// MARK: - Notification Delegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 앱이 foreground일 때 알림이 온 경우
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // 푸시 알림 상태창 표시
        completionHandler([.banner, .list, .badge, .sound])
    }
}

