//
//  ThirdCoordinator.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/26.
//

import UIKit

class ThirdCoordinator: Coordinator {
    let navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Tab1ThirdView", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! Tab1ThirdViewController
        viewController.delegate = self
        self.navigator.pushViewController(viewController, animated: true)
    }
}
extension ThirdCoordinator: Tab1ThirdViewDelegate {
    func home() {
        self.navigator.popToRootViewController(animated: true)
    }
}
