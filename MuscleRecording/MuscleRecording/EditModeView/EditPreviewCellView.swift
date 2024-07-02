//
//  EditPreviewCellView.swift
//  MuscleRecording
//
//  Created by 千千 on 6/25/24.
//

import SwiftUI

struct EditPreviewCellView: View {
    let bodyPart: BodyPart
    let bodySubPart: String
    let measurement: Measurement // 尺寸
    var body: some View {
        HStack(alignment: .top) {
            RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                .strokeBorder(Color.gray, lineWidth: 2)
                .foregroundStyle(.white)
                .frame(width: 80, height: 80)
                .overlay(alignment: .bottomTrailing) {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .padding(5)
                }
                .padding(.leading, 20)
            VStack(alignment: .leading) {
                GeometryReader { geometry in
                    VStack(alignment: .leading) {
                        Text(bodySubPart.bodySubPartTitle(bodyPart: bodyPart)).font(.title2)
                            .alignmentGuide(.top) { _ in geometry.size.height * 0.25 }
                        Spacer()
                        HStack(alignment: .bottom) {
                            Text(String(format: "%.1f", measurement.value)).font(.title)
                            Text("cm").font(.subheadline)
                        }
                        .alignmentGuide(.bottom) { _ in geometry.size.height }
                    }
                }
            }
            Spacer()
            Image(systemName: "pencil").font(.system(size: 42)).padding(20)
            
        }
        Divider()
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    return RecordingView(previewMode: .constant(false))
        .environmentObject(RecordingViewModel(context: context))
}
