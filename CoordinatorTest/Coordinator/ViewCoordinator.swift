//
//  ViewCoordinator.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/26.
//

import UIKit


class ViewCoordinator: Coordinator {
    let navigator: UINavigationController
    var vc: Tab1FirstViewController
    var secondCoordinator: SecondCoordinator?
    
    init(navigator: UINavigationController, vc: Tab1FirstViewController) {
        self.navigator = navigator
        self.vc = vc
    }
    
    func start() {
        vc.delegate = self
    }
}
extension ViewCoordinator: Tab1FirstViewDelegate {
    func push() {
        let coordinator = SecondCoordinator(navigator: self.navigator)
        coordinator.start()
        self.secondCoordinator = coordinator
    }
}
