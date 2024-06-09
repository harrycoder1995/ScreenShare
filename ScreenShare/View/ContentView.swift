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
    @ObservedObject var roomModel = HMSRoomModel(roomCode: "crs-tzqn-wuz",options: .init(appGroupName: "group.harendrarana.screenShare"))

    
    var body: some View {
        VStack {
            
            //Check Internet Connection is available or not and update the view accordingly
            if networkMonitor.isConnected
            {
                switch roomModel.roomState {
                case .notJoined:
                    JoiningView()
                case .inMeeting:
                    MeetingView()
                case .leftMeeting(_):
                   JoiningView()
                }
            }else {
                ContentUnavailableView("Internet Connection", systemImage: "wifi.slash", description: Text("You are not connected to Internet. Please check your internet Connection"))
            }
        }
        .padding()
        .environmentObject(roomModel)
    }
}

#Preview {
    ContentView()
}
