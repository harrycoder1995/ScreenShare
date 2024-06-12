//
//  JoiningView.swift
//  ScreenShare
//
//  Created by Harendra Rana on 09/06/24.
//

import SwiftUI
import HMSRoomModels

//Joining View with text Field and Button
struct JoiningView: View {
    
    @StateObject var roomModel: HMSRoomModel
    @State var username: String = ""
    @State var isMicMute = false
    @State var isVideoMute = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Enter Username:")
                    .bold()
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
            }
            .padding()
           
            HStack{
                Button(action: {
                   isVideoMute = !isVideoMute
                    roomModel.toggleCamera()
                }, label: {
                    Image(systemName: isVideoMute ? "video.slash": "video")
                })
                
                Spacer()
                
                Button(action: {
                    isMicMute.toggle()
                    roomModel.toggleMic()
                }, label: {
                    Image(systemName: isMicMute ? "mic.slash.fill" : "mic.fill")
                })
            }.frame(width: 100)
            
            Button(action: {
                Task {
                    try await roomModel.joinSession(userName:username)
                }
            }, label: {
                Text("Join Room")
                    .bold()
            })
            .padding()
            .foregroundStyle(.white)
            .background(Color.green)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    JoiningView(roomModel: HMSRoomModel(), username: "Harendra")
}
