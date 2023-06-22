//
//  NotesCompanionWatchOSApp.swift
//  NotesCompanionWatchOS
//
//  Created by Narayan Shettigar on 19/06/23.
//

import SwiftUI

@main
struct NotesCompanionWatchOSApp: App {
    @StateObject private var phoneConnectivityManager = PhoneConnectivityManager()

    var body: some Scene {
        WindowGroup {
            // Pass the PhoneConnectivityManager to ContentView
            ContentView().environmentObject(phoneConnectivityManager)
        }
    }
}

