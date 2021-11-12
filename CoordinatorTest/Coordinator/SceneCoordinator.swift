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
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "TabBarController", bundle: nil)
        let tabBarController = storyboard.instantiateInitialViewController() as! TabBarController
        
        let coordinator = TabBarCoordinator(tabBar: tabBarController)
        coordinator.start()
        self.tabBarCoordinator = coordinator
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
