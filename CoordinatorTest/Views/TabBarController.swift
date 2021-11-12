//
//  TabBarController.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/26.
//

import UIKit

protocol TabBarDelegate: AnyObject {
    func set()
}
class TabBarController: UITabBarController {
    weak var tabBarDelegate: TabBarDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarDelegate?.set()
    }
}
