//
//  Tab2SecondViewController.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/29.
//

import UIKit

protocol Tab2SecondDelegate: AnyObject {
    func push()
}
class Tab2SecondViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    weak var delegate: Tab2SecondDelegate?
    private var text = "" {willSet{print(newValue)}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = text
    }
    
    func inject(text: String) {
        self.text = text
    }
    
    @IBAction func button(_ sender: Any) {
        delegate?.push()
    }
}
