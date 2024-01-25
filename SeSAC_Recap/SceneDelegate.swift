//
//  SceneDelegate.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = scene.windows.first!
        
        if UserDefaultUtils.user.nickname.isEmpty {
            let vc = UIStoryboard(name: StoryboardId.onboarding, bundle: nil)
                .instantiateViewController(withIdentifier: OnboardingViewController.identifier)
            
            let nav = UINavigationController(rootViewController: vc)
            
            window.rootViewController = nav
            
        } else {
            let vc = UIStoryboard(name: StoryboardId.main, bundle: nil)
                .instantiateViewController(withIdentifier: UITabBarController.identifier)
            
            window.rootViewController = vc
        }
        
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // 뱃지 제거
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        // 사용자에 이미 전달된 노티 제거
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        // 사용자에 전달될 예정인 노티 제거
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

