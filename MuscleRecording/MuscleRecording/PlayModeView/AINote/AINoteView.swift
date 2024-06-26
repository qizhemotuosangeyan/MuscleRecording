//
//  AINoteView.swift
//  MuscleRecording
//
//  Created by 千千 on 6/26/24.
//

import SwiftUI

struct AINoteView: View {
    @StateObject var aiNoteViewModel = AINoteViewModel()
    @EnvironmentObject var data: RecordingViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("Note（AI建议）")
                .font(.title2)
            Text(aiNoteViewModel.aiText)
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 15.0)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            aiNoteViewModel.fetchPosts(bodyDescription: data.bodyDescription)
        }
        
    }
}

#Preview {
    AINoteView()
}
