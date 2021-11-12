//
//  SecondViewController.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/26.
//

import UIKit

protocol Tab1SecondViewDelegate: AnyObject {
    func push()
}
class Tab1SecondViewController: UIViewController {
    weak var delegate: Tab1SecondViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func button(_ sender: Any) {
        delegate?.push()
    }
}
