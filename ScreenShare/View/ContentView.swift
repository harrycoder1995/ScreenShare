//
//  ContentView.swift
//  ScreenShare
//
//  Created by Harendra Rana on 08/06/24.
//

import SwiftUI
import HMSRoomModels

struct ContentView: View {

    @Environment(NetworkMonitor.self) private var networkMonitor
    @ObservedObject var manager = HMSManager()

    
    var body: some View {
        VStack {
            //Check Internet Connection is available or not and update the view accordingly
            if networkMonitor.isConnected {
                
                //Check RoomModel exist or not
                if let roomModel = manager.roomModel {
                    switch roomModel.roomState {
                    case .notJoined, .leftMeeting(_):
                        JoiningView(roomModel: roomModel)
                    case .inMeeting:
                        MeetingView(roomModel: roomModel)
                    }
                }else {
                    //Show ContentUnavailable Screen if room code is not available
                    ContentUnavailableView("No-Active Room Available", systemImage: "laptopcomputer.slash", description: Text("Room code is incorrect or not-available.Please check once with the host."))
                }
            }else {
                //Show Content Unavailable Screen if Internet is not available
                ContentUnavailableView("Internet Connection", systemImage: "wifi.slash", description: Text("You are not connected to Internet. Please check your internet Connection"))
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
