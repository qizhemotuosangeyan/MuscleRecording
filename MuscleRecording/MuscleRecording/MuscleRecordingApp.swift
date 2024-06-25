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
    @StateObject var data = RecordingViewModel()
    var body: some Scene {
        WindowGroup {
            RecordingView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(data)
        }
    }
}
