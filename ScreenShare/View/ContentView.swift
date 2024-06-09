//
//  ContentView.swift
//  ScreenShare
//
//  Created by Harendra Rana on 08/06/24.
//

import SwiftUI
import HMSRoomModels

struct ContentView: View {
    
    @ObservedObject var roomModel = HMSRoomModel(roomCode: "crs-tzqn-wuz",options: .init(appGroupName: "group.harendrarana.screenShare"))

    
    var body: some View {
        VStack {
            switch roomModel.roomState {
            case .notJoined:
                JoiningView()
            case .inMeeting:
                MeetingView()
            case .leftMeeting(_):
               JoiningView()
            }
        }
        .padding()
        .environmentObject(roomModel)
    }
}

#Preview {
    ContentView()
}
