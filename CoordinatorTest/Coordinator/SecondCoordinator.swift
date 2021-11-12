//
//  SecondCoordinator.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/26.
//

import UIKit

class SecondCoordinator: Coordinator {
    let navigator: UINavigationController
    var thirdCoordinator: ThirdCoordinator?
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Tab1SecondView", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! Tab1SecondViewController
        viewController.delegate = self
        self.navigator.pushViewController(viewController, animated: true)
    }
}
extension SecondCoordinator: Tab1SecondViewDelegate {
    func push() {
        let coordinator = ThirdCoordinator(navigator: self.navigator)
        coordinator.start()
        thirdCoordinator = coordinator
    }
}
