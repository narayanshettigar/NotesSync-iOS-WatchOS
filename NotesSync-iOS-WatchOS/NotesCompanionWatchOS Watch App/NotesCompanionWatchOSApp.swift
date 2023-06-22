//
//  NotesCompanionWatchOSApp.swift
//  NotesCompanionWatchOS Watch App
//
//  Created by Narayan Shettigar on 19/06/23.
//

import SwiftUI

@main
struct NotesCompanionWatchOS_Watch_AppApp: App {
    // Create an instance of the WatchConnectivityManager
    @StateObject private var watchConnectivityManager = WatchConnectivityManager()

    var body: some Scene {
        WindowGroup {
            // Pass the WatchConnectivityManager to ContentView
            ContentView().environmentObject(watchConnectivityManager)
        }
    }
}
