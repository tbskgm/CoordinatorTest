//
//  SceneCoordinator.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/26.
//

import UIKit

class SceneCoordinator: Coordinator {
    let window: UIWindow
    var tabBarCoordinator: TabBarCoordinator?
    let launchType: LaunchType
    
    enum LaunchType {
        case normal
        case notification(_ notification: UNNotificationRequest)
    }
    
    init(window: UIWindow, launchType: LaunchType) {
        self.window = window
        self.launchType = launchType
    }
    
    func start() {
        defer {
            window.makeKeyAndVisible()
        }
        
        switch launchType {
        case .normal: // 通常起動ではlaunchTypeがnilなのでbreakを設定しています
            let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
            let tabBarController = storyboard.instantiateInitialViewController() as! TabBarController
            
            let coordinator = TabBarCoordinator(tabBar: tabBarController)
            coordinator.start()
            self.tabBarCoordinator = coordinator
            
            window.rootViewController = tabBarController
            
        case .notification(let request):
            if request.trigger is UNPushNotificationTrigger { // remote
                // remote notification
            } else if request.trigger is UNTimeIntervalNotificationTrigger { // local
                // local notification
                window.rootViewController = UIViewController()
            }
        }
    }
}
