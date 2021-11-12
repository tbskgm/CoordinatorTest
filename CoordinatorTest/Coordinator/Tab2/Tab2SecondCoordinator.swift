//
//  Tab2SecondCoordinator.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/29.
//

import UIKit

class Tab2SecondCoordinator: Coordinator {
    let navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Tab2SecondView", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! Tab2SecondViewController
        viewController.inject(text: "無量空処")
        viewController.delegate = self
        navigator.pushViewController(viewController, animated: true)
    }
    
}
extension Tab2SecondCoordinator: Tab2SecondDelegate {
    func push() {
        navigator.popToRootViewController(animated: true)
    }
}
