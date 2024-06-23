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
    
    
    //Method to get the token if registeration is successful
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print(token)
    }
    
    //Method will print the error if failed to register.
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
        print("Fail to register for remote notification.", error.localizedDescription)
    }
    
}
