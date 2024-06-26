//
//  RecordingView.swift
//  MuscleRecording
//
//  Created by 千千 on 6/22/24.
//

import SwiftUI

struct RecordingView: View {
    @State var choosingBodyPart: BodyPart = .Arms
    @State var choosingSubPart: String?
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
                        Text(bodyPart.title).tag(bodyPart)
                    }
                }
                .pickerStyle(.segmented)
                list
                    .sheet(item: $choosingSubPart) { subPart in
                        EditSheetView(bodyPart: choosingBodyPart, subPart: subPart, choosingSubPart: $choosingSubPart)
                            .presentationDetents([.medium])
                    }
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
    }
    @ViewBuilder var list: some View {
        switch choosingBodyPart {
        case .Deltoids:
            ForEach(BodyPart.DeltoidPart.allCases) { deltoid in
                EditPreviewCellView(bodyPart: .Deltoids, bodySubPart: deltoid.rawValue, measurement: data.measurements[.Deltoids]![deltoid.rawValue]!)
                    .contentShape(Rectangle())
                    .onHapticTapGesture {
                        choosingSubPart = deltoid.rawValue
                    }
            }
        case .Chest:
            ForEach(BodyPart.ChestPart.allCases) { chest in
                EditPreviewCellView(bodyPart: .Chest, bodySubPart: chest.rawValue, measurement: data.measurements[.Chest]![chest.rawValue]!)
                    .contentShape(Rectangle())
                    .onHapticTapGesture {
                        choosingSubPart = chest.rawValue
                    }
            }
        case .Arms:
            ForEach(BodyPart.ArmPart.allCases) { arm in
                EditPreviewCellView(bodyPart: .Arms, bodySubPart: arm.rawValue, measurement: data.measurements[.Arms]![arm.rawValue]!)
                    .contentShape(Rectangle())
                    .onHapticTapGesture {
                        choosingSubPart = arm.rawValue
                    }
            }
        case .Core:
            ForEach(BodyPart.CorePart.allCases) { core in
                EditPreviewCellView(bodyPart: .Core, bodySubPart: core.rawValue, measurement: data.measurements[.Core]![core.rawValue]!)
                    .contentShape(Rectangle())
                    .onHapticTapGesture {
                        choosingSubPart = core.rawValue
                    }
            }
        case .Thighs:
            ForEach(BodyPart.ThighsPart.allCases) { thigh in
                EditPreviewCellView(bodyPart: .Thighs, bodySubPart: thigh.rawValue, measurement: data.measurements[.Thighs]![thigh.rawValue]!)
                    .contentShape(Rectangle())
                    .onHapticTapGesture {
                        choosingSubPart = thigh.rawValue
                    }
            }
        case .Calves:
            ForEach(BodyPart.CalfPart.allCases) { calf in
                EditPreviewCellView(bodyPart: .Calves, bodySubPart: calf.rawValue, measurement: data.measurements[.Calves]![calf.rawValue]!)
                    .contentShape(Rectangle())
                    .onHapticTapGesture {
                        choosingSubPart = calf.rawValue
                    }
            }
        }
    }
}

extension String: Identifiable {
    public var id: String { self }
}

struct HapticTapGesture: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onTapGesture {
                // 触发震动反馈
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()

                // 执行传入的动作
                action()
            }
    }
}

extension View {
    func onHapticTapGesture(action: @escaping () -> Void) -> some View {
        self.modifier(HapticTapGesture(action: action))
    }
}
#Preview {
    RecordingView()
        .environmentObject(RecordingViewModel())
}
