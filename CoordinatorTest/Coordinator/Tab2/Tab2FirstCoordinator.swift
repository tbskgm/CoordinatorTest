//
//  Tab2FirstCoordinator.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/29.
//

import UIKit

class Tab2FirstCoordinator: Coordinator {
    let navigator: UINavigationController
    let vc: Tab2FirstViewController
    var tab2SecondCoordinator: Tab2SecondCoordinator?
    
    init(navigator: UINavigationController, vc: Tab2FirstViewController) {
        self.navigator = navigator
        self.vc = vc
    }
    
    func start() {
        vc.delegate = self
        vc.inject(text: "お財布ケータイ")
    }
}
extension Tab2FirstCoordinator: Tab2FirstDelegate {
    func push() {
        // 次の画面へ遷移
        let coordinator = Tab2SecondCoordinator(navigator: self.navigator)
        coordinator.start()
        self.tab2SecondCoordinator = coordinator
    }
}
