//
//  TabBarCoordinator.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/26.
//

import UIKit

class TabBarCoordinator: Coordinator {
    let tabBarController: TabBarController
    var viewCoordinator: ViewCoordinator?
    var tab2Coordinator: Tab2FirstCoordinator?
    
    init(tabBar: TabBarController) {
        self.tabBarController = tabBar
    }
    
    func start() {
        tabBarController.tabBarDelegate = self
    }
}
extension TabBarCoordinator: TabBarDelegate {
    func set() {
        // Tab1 の作成
        let storyBoard = UIStoryboard(name: "Tab1FirstView", bundle: nil)
        let navigationController = storyBoard.instantiateInitialViewController() as! UINavigationController
        let tab1ViewController = navigationController.topViewController as! Tab1FirstViewController
        let coordinator = ViewCoordinator(navigator: navigationController, vc: tab1ViewController)
        coordinator.start()
        self.viewCoordinator = coordinator
        
        // Tab2 の作成
        let storyboard = UIStoryboard(name: "Tab2FirstView", bundle: nil)
        let tab2NavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let tab2ViewController = tab2NavigationController.topViewController as! Tab2FirstViewController
        let tab2Coordinator = Tab2FirstCoordinator(navigator: tab2NavigationController, vc: tab2ViewController)
        tab2Coordinator.start()
        self.tab2Coordinator = tab2Coordinator
        
        // tabBarに追加
        let viewControllers = [navigationController, tab2NavigationController]
        self.tabBarController.setViewControllers(viewControllers, animated: true)
    }
}
