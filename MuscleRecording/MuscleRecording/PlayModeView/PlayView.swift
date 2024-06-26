//
//  PlayView.swift
//  MuscleRecording
//
//  Created by 千千 on 6/22/24.
//

import SwiftUI

struct PlayView: View {
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
                
            }
        }
    }
}

#Preview {
    PlayView()
        .environmentObject(RecordingViewModel())

}
