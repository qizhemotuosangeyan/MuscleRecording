//
//  PlayView.swift
//  MuscleRecording
//
//  Created by 千千 on 6/22/24.
//

import SwiftUI

struct PlayView: View {
    @Binding var previewMode: Bool
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // 人体图和叠加注释
                PlayBodyView()
                    .padding(.bottom, 30)
                ReminderView()
                AINoteView()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .topLeading) {
                HStack(spacing: 5){
                    Image(systemName: "play.square")
                    Text("预览模式")
                }
                .foregroundStyle(.orange)
                .font(.title3)
                .onHapticTapGesture {
                    previewMode = false
                }
                
            }
        }
        .scrollIndicators(.hidden)
        .padding(20)
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    return PlayView(previewMode: .constant(true))
        .environmentObject(RecordingViewModel(context: context))
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

}
