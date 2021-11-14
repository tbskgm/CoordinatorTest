//
//  ViewController.swift
//  CoordinatorTest
//
//  Created by TsubasaKogoma on 2021/10/26.
//

import UIKit
import CoreSpotlight

protocol Tab1FirstViewDelegate: AnyObject {
    func push()
}
class Tab1FirstViewController: UIViewController {
    weak var delegate: Tab1FirstViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 通知許可の取得
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ (granted, _) in
            if granted {
                let application = UIApplication.shared
                
                DispatchQueue.main.async {
                    // Apple Push Notificationサービスによるリモート通知の受信を登録します。
                    application.registerForRemoteNotifications()
                }
            }
        }
        
        // Core Spotlight
        let items = [
            insert(title: "お財布携帯", description: "Apple Payではスマホで決済できます。", keywords: ["Apple Pay", "お財布携帯", "支払い"]),
            insert(title: "無量空処", description: "領域展開 無量空処。", keywords: ["呪術廻戦", "無料空処", "領域展開"])
        ]
        CSSearchableIndex.default().indexSearchableItems(items) { error in
            if let e = error {
                print("\(e)")
            }
        }
    }
    
    func addNotification() {
        let content = UNMutableNotificationContent()
        /// 通知メッセージ
        content.title = "ローカル通知"
        content.body = "ローカル通知は通知されました"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        /// 通知リクエストを作成して登録する
        let request = UNNotificationRequest(identifier: "ローカル通知", content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
        }
    }
    
    /// spotlightで使用
    func insert(identifier id: String? = nil, title: String, description: String, keywords: [String]) -> CSSearchableItem {
        let identifier: String!
        if id == nil {
            identifier = id
        } else {
            identifier = id
        }
        
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: "test")
        attributeSet.title = title
        attributeSet.contentDescription = description
        attributeSet.keywords = keywords
        let item = CSSearchableItem(uniqueIdentifier:identifier, domainIdentifier: nil, attributeSet: attributeSet)
        return item
    }
    
    /// ローカル通知を作成
    @IBAction func notificationButton(_ sender: Any) {
        addNotification()
    }
    
    @IBAction func button(_ sender: Any) {
        delegate?.push()
    }
}
