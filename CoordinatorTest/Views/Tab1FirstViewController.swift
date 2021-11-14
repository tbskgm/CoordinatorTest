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
        
        // 通知許可の取得
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ (granted, _) in
            if granted{
                //UNUserNotificationCenter.current().delegate = self
            }
        }
    }
    
    func addNotification() {
        let content = UNMutableNotificationContent()
        /// 通知メッセージ
        content.title = "ローカル通知"
        content.body = "ローカル通知は通知されました"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        /// 通知リクエストを作成して登録する
        let request = UNNotificationRequest(identifier: "ローカル通知", content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
        }
    }
    
    /// リモート通知を発行する
    @IBAction func remoteNotificationButton(_ sender: Any) {
    }
    
    
    /// ローカル通知を作成
    @IBAction func notificationButton(_ sender: Any) {
        addNotification()
    }
    
    @IBAction func button(_ sender: Any) {
        delegate?.push()
    }
}
