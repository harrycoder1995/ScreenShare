//
//  ScreenShareApp.swift
//  ScreenShare
//
//  Created by Harendra Rana on 08/06/24.
//

import SwiftUI
import UserNotifications

@main
struct ScreenShareApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)var appDelegate
    @StateObject private var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(networkMonitor)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var notificationManager = NotificationManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Task {
            if await notificationManager.request() {
                application.registerForRemoteNotifications()
            }
        }
        return true
    }
    
}
