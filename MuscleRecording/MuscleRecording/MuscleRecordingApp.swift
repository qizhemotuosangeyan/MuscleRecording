//
//  MuscleRecordingApp.swift
//  MuscleRecording
//
//  Created by 千千 on 6/22/24.
//

import SwiftUI

@main
struct MuscleRecordingApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject var data = RecordingViewModel()
    @AppStorage("LetsGo") private var letsGoButtonClicked: Bool = false
    @AppStorage("ImReady") private var ImReadyButtonClicked: Bool = false
    @State var previewMode: Bool = false
    var body: some Scene {
        WindowGroup {
            if !letsGoButtonClicked {
                LetsGoView()
            }else if !ImReadyButtonClicked {
                ImReadyView()
            } else if previewMode{
                PlayView(previewMode: $previewMode)
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(data)
            } else {
                RecordingView(previewMode: $previewMode)
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(data)
            }
        }
    }
}
