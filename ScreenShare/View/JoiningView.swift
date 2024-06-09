//
//  JoiningView.swift
//  ScreenShare
//
//  Created by Harendra Rana on 09/06/24.
//

import SwiftUI
import HMSRoomModels

struct JoiningView: View {
    
    @EnvironmentObject var roomModel: HMSRoomModel
    @State var username: String = ""
    
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
                Button(action: {}, label: {
                    Image(systemName: "video.slash")
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "mic.slash.fill")
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
    JoiningView(username: "Harendra")
}
