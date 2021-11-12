//
//  ThirdViewController.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/26.
//

import UIKit

protocol Tab1ThirdViewDelegate: AnyObject {
    func home()
}
class Tab1ThirdViewController: UIViewController {
    weak var delegate: Tab1ThirdViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func button(_ sender: Any) {
        delegate?.home()
    }
}
