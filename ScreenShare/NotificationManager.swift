//
//  NotificationManager.swift
//  ScreenShare
//
//  Created by Harendra Rana on 10/06/24.
//

import Foundation
import UserNotifications

//Notification Handler
class NotificationManager: NSObject {
    
    private(set) var roomCode: String?
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
        
        //Code for testing the notification flow
//        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
//            self.handleNotification(roomCode: "crs-tzqn-wuz")
//        }
    }
    
    //Request For notification
    func request() async -> Bool  {
        do {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
            return true
        } catch{
            return false
        }
    }
    
    //Code for testing purpose
//    func handleNotification(roomCode: String?) {
//        self.roomCode = roomCode
//        NotificationCenter.default.post(name: Notification.Name("onRoomCodeRecieved"), object: nil)
//    }
    
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        roomCode = response.notification.request.content.userInfo["roomCode"] as? String
        NotificationCenter.default.post(name: Notification.Name("onRoomCodeRecieved"), object: nil)
        completionHandler()
    }
    
}
