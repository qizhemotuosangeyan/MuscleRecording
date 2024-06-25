//
//  RecordingView.swift
//  MuscleRecording
//
//  Created by 千千 on 6/22/24.
//

import SwiftUI

struct RecordingView: View {
    @State var choosingBodyPart: BodyPart = .Arms
    @EnvironmentObject var data: RecordingViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // 人体图和叠加注释
                ZStack(alignment:.topLeading) {
                    GeometryReader { geometry in
                        Image(ImageResource.body)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 262, height: 427)
                            .overlay {
                                LineWithAnnotation(
                                    start: CGPoint(x: geometry.size.width * 0.68, y: geometry.size.height * 0.22), // 根据实际需要调整
                                    end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.04),
                                    bodyType: BodyPart.Deltoids, picked: $choosingBodyPart
                                )
                                LineWithAnnotation(
                                    start: CGPoint(x: geometry.size.width * 0.62, y: geometry.size.height * 0.26), // 根据实际需要调整
                                    end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.18),
                                    bodyType: BodyPart.Chest, picked: $choosingBodyPart
                                )
                                LineWithAnnotation(
                                    start: CGPoint(x: geometry.size.width * 0.73, y: geometry.size.height * 0.33), // 根据实际需要调整
                                    end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.3),
                                    bodyType: BodyPart.Arms, picked: $choosingBodyPart
                                )
                                LineWithAnnotation(
                                    start: CGPoint(x: geometry.size.width * 0.53, y: geometry.size.height * 0.45), // 根据实际需要调整
                                    end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.56),
                                    bodyType: BodyPart.Core, picked: $choosingBodyPart
                                )
                                LineWithAnnotation(
                                    start: CGPoint(x: geometry.size.width * 0.60, y: geometry.size.height * 0.55), // 根据实际需要调整
                                    end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.7),
                                    bodyType: BodyPart.Thighs, picked: $choosingBodyPart
                                )
                                LineWithAnnotation(
                                    start: CGPoint(x: geometry.size.width * 0.63, y: geometry.size.height * 0.75), // 根据实际需要调整
                                    end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.9),
                                    bodyType: BodyPart.Calves, picked: $choosingBodyPart
                                )
                            }
                    }
                }
                .padding(.top, 10)
                .frame(width: 262, height: 427)
                .frame(alignment: .leading)
                Picker("", selection: $choosingBodyPart) {
                    ForEach(BodyPart.allCases) { bodyPart in
                        Text(bodyPart.rawValue.capitalized).tag(bodyPart)
                    }
                }
                .pickerStyle(.segmented)
                list
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .topLeading) {
                HStack(spacing: 5){
                    Image(systemName: "square.and.pencil")
                    Text("编辑模式")
                }
                .foregroundStyle(.orange)
                .font(.title3)
                
            }
        }
        //        .border(.yellow)
    }
    @ViewBuilder var list: some View {
        switch choosingBodyPart {
        case .Deltoids:
            ForEach(BodyPart.DeltoidPart.allCases) { deltoid in
                if let measurement = data.measurements[.Deltoids]?[deltoid.rawValue] {
                    EditPreviewCellView(measurement: measurement)
                }
            }
        case .Chest:
            ForEach(BodyPart.ChestPart.allCases) { chest in
                if let measurement = data.measurements[.Chest]?[chest.rawValue] {
                    EditPreviewCellView(measurement: measurement)
                }
            }
        case .Arms:
            ForEach(BodyPart.ArmPart.allCases) { arm in
                if let measurement = data.measurements[.Arms]?[arm.rawValue] {
                    EditPreviewCellView(measurement: measurement)
                }
            }
        case .Core:
            ForEach(BodyPart.CorePart.allCases) { core in
                if let measurement = data.measurements[.Core]?[core.rawValue] {
                    EditPreviewCellView(measurement: measurement)
                }
            }
        case .Thighs:
            ForEach(BodyPart.ThighsPart.allCases) { thigh in
                if let measurement = data.measurements[.Thighs]?[thigh.rawValue] {
                    EditPreviewCellView(measurement: measurement)
                }
            }
        case .Calves:
            ForEach(BodyPart.CalfPart.allCases) { calf in
                if let measurement = data.measurements[.Calves]?[calf.rawValue] {
                    EditPreviewCellView(measurement: measurement)
                }
            }
        }
    }
}


#Preview {
    RecordingView()
        .environmentObject(RecordingViewModel())
    //    EditPreviewCellView(measurement: Measurement(bodyPart: .Arms, subPart: BodyPart.ArmPart.Wrist.rawValue, value: 25))
}
