//
//  SceneCoordinator.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/26.
//

import UIKit
import CoreSpotlight

class SceneCoordinator: Coordinator {
    let window: UIWindow
    var tabBarCoordinator: TabBarCoordinator?
    let launchType: LaunchType
    
    // TODO: 下記のプロパティが３つもあるのでうまく統合すること
    private let gcmMessageIDKey = "gcm.message_id"
    
    enum LaunchType {
        case normal
        case notification(_ notification: UNNotificationRequest)
        case userActivity(NSUserActivity)
        case openURL
        case shortCutItem(UIApplicationShortcutItem)
        case siriShortCutItem
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
            print("normal")
            let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
            let tabBarController = storyboard.instantiateInitialViewController() as! TabBarController
            
            let coordinator = TabBarCoordinator(tabBar: tabBarController)
            coordinator.start()
            self.tabBarCoordinator = coordinator
            
            window.rootViewController = tabBarController
            
        case .notification(let request):
            print("notification+")
            if request.trigger is UNPushNotificationTrigger {
                // remote notification
                let userInfo = request.content.userInfo
                
                if let messageID = userInfo[gcmMessageIDKey] {
                    print("Message ID: \(messageID)")
                }
                print(userInfo)
                
                // 遷移先画面の作成
                let storyboard = UIStoryboard(name: "RemoteNotificationView", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController() as! RemoteNotificationViewController
                window.rootViewController = viewController
            } else if request.trigger is UNTimeIntervalNotificationTrigger {
                // local notification
                let storyboard = UIStoryboard(name: "LocalNotificationView", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController() as! LocalNotificationViewController
                window.rootViewController = viewController
            }
        case .userActivity(let userActivity):
            switch userActivity.activityType {
            case NSUserActivityTypeBrowsingWeb:
                // universal links
                let storyboard = UIStoryboard(name: "UniversalLinksView", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController() as! UniversalLinksViewController
                window.rootViewController = viewController
            case CSSearchableItemActionType:
                // Core spotlight
                let storyboard = UIStoryboard(name: "CoreSpotlightView", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController() as! CoreSpotlightViewController
                window.rootViewController = viewController
            case CSQueryContinuationActionType:
                // Core soptlight (incremental search)
                window.rootViewController = UIViewController()
            case "ConfigurationIntent":
                let storyboard = UIStoryboard(name: "OpenURLView", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController() as! OpenURLViewController
                window.rootViewController = viewController
            case "Siri":
                let storyboard = UIStoryboard(name: "SiriShortCutView", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController() as! SiriShortCutViewController
                window.rootViewController = viewController
            default:
                fatalError("Unreachable userActivity: ’\(userActivity.activityType)'")
            }
        case .openURL:
            let storyboard = UIStoryboard(name: "OpenURLView", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController() as! OpenURLViewController
            window.rootViewController = viewController
        case .shortCutItem(_):
            let storyboard = UIStoryboard(name: "ShortCutItemView", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController() as! ShortCutItemViewController
            window.rootViewController = viewController
        case .siriShortCutItem:
            let storyboard = UIStoryboard(name: "SiriShortCutView", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController() as! SiriShortCutViewController
            window.rootViewController = viewController
        }
    }
}
