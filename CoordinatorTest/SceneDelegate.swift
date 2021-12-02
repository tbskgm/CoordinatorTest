//
//  SceneDelegate.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var sceneCoordinator: SceneCoordinator?
    
    private let gcmMessageIDKey = "gcm.message_id"

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        UNUserNotificationCenter.current().delegate = self
        
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        
        /// launchType
        let launchType: SceneCoordinator.LaunchType!
        
        if connectionOptions.notificationResponse != nil {
            // 通知
            launchType = .notification((connectionOptions.notificationResponse?.notification.request)!)
        } else if connectionOptions.handoffUserActivityType == "Siri" {
            launchType = .siriShortCutItem
        } else if connectionOptions.userActivities.first != nil {
            // spotlight
            let userActivity = connectionOptions.userActivities.first
            launchType = .userActivity(userActivity!)
        } else if connectionOptions.urlContexts.first?.url != nil {
            // openURL
            launchType = .openURL
        } else if connectionOptions.shortcutItem != nil {
            // Quick Action(3D Touch)
            launchType = .shortCutItem(connectionOptions.shortcutItem!)
        } else {
            // 通常起動
            launchType = .normal
        }
        
        let coordinator = SceneCoordinator(window: window, launchType: launchType)
        coordinator.start()
        
        self.sceneCoordinator = coordinator
        self.window = window
    }
    
    /// バックグラウンド時のspotlightが呼ばれる
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard let window = self.window else {
            return
        }
        let launchType: SceneCoordinator.LaunchType!
        if userActivity.activityType == "ConfigurationIntent" {
            launchType = .openURL
        } else if userActivity.activityType == "Siri" {
            launchType = .siriShortCutItem
        } else {
            launchType = .userActivity(userActivity)
        }
        let sceneCoordinator = SceneCoordinator(window: window, launchType: launchType)
        sceneCoordinator.start()
        self.sceneCoordinator = sceneCoordinator
    }
    
    /// バックグラウンド時のopenURLが呼ばれる
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let window = self.window else {
            return
        }
        //let url = URLContexts.first!.url
        let launchType: SceneCoordinator.LaunchType = .openURL
        let sceneCoordinator = SceneCoordinator(window: window, launchType: launchType)
        sceneCoordinator.start()
        self.sceneCoordinator = sceneCoordinator
    }
    
    /// バックグラウンド時のQuick Action(3D Tuch)
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem) async -> Bool {
        guard let window = self.window else {
            return false
        }
        let launchType: SceneCoordinator.LaunchType = .shortCutItem(shortcutItem)
        let sceneCoordinator = SceneCoordinator(window: window, launchType: launchType)
        sceneCoordinator.start()
        self.sceneCoordinator = sceneCoordinator
        return true
    }
    
    /// Siri
    


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
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
extension SceneDelegate: UNUserNotificationCenterDelegate {
    // バックグラウンド時、未起動時に通知される
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
        guard let window = self.window else { return }

        let request = response.notification.request
        let launchType: SceneCoordinator.LaunchType = .notification(request)

        let sceneCoordinator = SceneCoordinator(window: window, launchType: launchType)
        sceneCoordinator.start()
        self.sceneCoordinator = sceneCoordinator
        
        completionHandler()
    }
    
    // フォアグラウンド時に通知される
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(#function)
        
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler([.banner, .list, .sound])
    }
}
