//
//  ViewController.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/26.
//

import UIKit

protocol Tab1FirstViewDelegate: AnyObject {
    func push()
}
class Tab1FirstViewController: UIViewController {
    weak var delegate: Tab1FirstViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func button(_ sender: Any) {
        delegate?.push()
    }
}
