//
//  NetworkMonitor.swift
//  ScreenShare
//
//  Created by Harendra Rana on 09/06/24.
//

import Foundation
import Network

@Observable
class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
       private let workerQueue = DispatchQueue(label: "com.screenShare.networkMonitor")
       var isConnected = false
       
       init() {
           networkMonitor.pathUpdateHandler = { path in
               self.isConnected = path.status == .satisfied
           }
           networkMonitor.start(queue: workerQueue)
       }
}
