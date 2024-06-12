//
//  HMSManager.swift
//  ScreenShare
//
//  Created by Harendra Rana on 10/06/24.
//

import Foundation
import HMSRoomModels
import SwiftUI

//Creating the roomModel based on the room code
class HMSManager: ObservableObject {
    @Published var roomModel: HMSRoomModel? = nil
    var notificationManager = NotificationManager()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(generateRoomModel), name: Notification.Name("onRoomCodeRecieved"), object: nil)
        generateRoomModel()
    }
    
    //Generate room Model when we recieved from the notification
    @objc private func generateRoomModel() {
        if let roomCode = notificationManager.roomCode {
            roomModel = HMSRoomModel(roomCode: roomCode, options: .init(appGroupName: "group.harendrarana.screenShare",screenShareBroadcastExtensionBundleId: "com.harendra.ScreenShare.ScreenShareBroadcast"))
            
            NotificationCenter.default.removeObserver(self)
        }
    }
    
}

extension HMSRoomModel {
    convenience init() {
        self.init(roomCode: "")
    }
}
