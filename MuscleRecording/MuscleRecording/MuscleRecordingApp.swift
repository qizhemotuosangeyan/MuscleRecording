//
//  MuscleRecordingApp.swift
//  MuscleRecording
//
//  Created by 千千 on 6/22/24.
//

import SwiftUI

@main
struct MuscleRecordingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
