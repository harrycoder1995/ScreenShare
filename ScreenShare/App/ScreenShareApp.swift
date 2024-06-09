//
//  ScreenShareApp.swift
//  ScreenShare
//
//  Created by Harendra Rana on 08/06/24.
//

import SwiftUI

@main
struct ScreenShareApp: App {
    @State private var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(networkMonitor)
        }
    }
}
