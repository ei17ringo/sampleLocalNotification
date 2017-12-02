//
//  ViewController.swift
//  sampleLocalNotification
//
//  Created by Eriko Ichinohe on 2017/12/02.
//  Copyright © 2017年 Eriko Ichinohe. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var settingDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //通知の許可を出す
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
        
    }

    @IBAction func pushSecond(_ sender: UIButton) {
        
        // Notificatiのインスタンス生成
        let content = UNMutableNotificationContent()
        
        // タイトルを設定する
        content.title = "ファイヤー！"
        
        // 通知の本文です
        content.body = "10秒経ったよ"
        
        // デフォルトの音に設定します
        content.sound = UNNotificationSound.default()
        
        // Triggerを生成(いつ通知が来るのか)
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 10, repeats: false)
        
        // Requestを生成する。idには通知IDを設定する
        let request = UNNotificationRequest.init(identifier: "ID_TenSecond", content: content, trigger: trigger)
        
        // Noticationを生成する
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
        }
    }
    
    @IBAction func pushSpecificTime(_ sender: UIButton) {
        
        var settingDateTime = settingDatePicker.date
        
        //文字列変換
        var df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd hh:mm:00"
        var strDate = df.string(from: settingDateTime)
        
        // Notificatiのインスタンス生成
        let content = UNMutableNotificationContent()
        
        // タイトルを設定する
        content.title = "指定時間になりました"
        
        // 通知の本文です
        content.body = "\(strDate)ですよ"
        
        // デフォルトの音に設定します
        content.sound = UNNotificationSound.default()
        
        //着火時間の設定
        
        var setDateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: settingDateTime)
        setDateComponents.second = 0

        var dateComponents = DateComponents()
        dateComponents.year = setDateComponents.year!
        dateComponents.month = setDateComponents.month!
        dateComponents.day = setDateComponents.day!

        dateComponents.hour = setDateComponents.hour!
        dateComponents.minute = setDateComponents.minute!
        dateComponents.second = 0


        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
        // Requestを生成する。idには通知IDを設定する
        let request = UNNotificationRequest.init(identifier: "ID_SetDayAndTime", content: content, trigger: calendarTrigger)
        
        // Noticationを発行する.
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error ?? "\(setDateComponents.year!)年\(setDateComponents.month!)月\(setDateComponents.day!)日\(setDateComponents.hour!)時\(setDateComponents.minute!)分発動！")
            
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

