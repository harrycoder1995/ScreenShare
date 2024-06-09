//
//  MeetingView.swift
//  ScreenShare
//
//  Created by Harendra Rana on 09/06/24.
//

import SwiftUI
import HMSRoomModels
import HMSBroadcastExtensionSDK

struct MeetingView: View {
    
    @EnvironmentObject var roomModel: HMSRoomModel
    
    @StateObject var broadcastPickerView = {
           let picker = RPSystemBroadcastPickerView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
           picker.showsMicrophoneButton = false
           return picker
       }()
    
    var body: some View {
        VStack {
            List {
                
                // If a participant is sharing their screen, show their screen at the top of the list
                if roomModel.peersSharingScreen.count > 0 {
                    TabView {
                        ForEach(roomModel.peersSharingScreen) { screenSharingPeer in
                            HMSScreenTrackView(peer: screenSharingPeer)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 200)
                }
                
                // Render video of each peer in the call
                ForEach(roomModel.peerModels) { peerModel in
                    
                    VStack {
                        Text(peerModel.name)
                        HMSVideoTrackView(peer: peerModel)
                            .frame(height: 200)
                    }
                }
            }
            
            HStack {
                
                //Show Microphone to enable or disable the audio
                Image(systemName: roomModel.isMicMute ? "mic.slash" : "mic")
                    .onTapGesture {
                        roomModel.toggleMic()
                    }
                
                //Show Camera to enable or disable the video
                Image(systemName: roomModel.isCameraMute ? "video.slash" : "video")
                    .onTapGesture {
                        roomModel.toggleCamera()
                    }
                
                //Button to leave the room
                Image(systemName: "phone.down.fill")
                    .onTapGesture {
                        Task {
                            try await roomModel.leaveSession()
                        }
                    }
                
                //Check if user can share the screen or not
                if roomModel.userCanShareScreen {
                    Image(systemName: "rectangle.inset.filled.and.person.filled")
                        .onTapGesture {
                            for subview in broadcastPickerView.subviews {
                                if let button = subview as? UIButton {
                                    button.sendActions(for: UIControl.Event.allTouchEvents)
                                }
                            }
                        }
                        .onAppear() {
                            broadcastPickerView.preferredExtension = "com.harendra.ScreenShare.ScreenShareBroadcast"
                        }
                }
            }
        }
    }
}

#Preview {
    MeetingView()
}
