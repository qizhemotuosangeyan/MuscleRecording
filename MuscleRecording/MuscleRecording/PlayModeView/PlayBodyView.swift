//
//  PlayBodyView.swift
//  MuscleRecording
//
//  Created by 千千 on 6/22/24.
//

import SwiftUI

struct PlayBodyView: View {
    @EnvironmentObject var data: RecordingViewModel
    var body: some View {
        ZStack(alignment:.topLeading) {
            GeometryReader { geometry in
                Image(ImageResource.body)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 262, height: 427)
                    .overlay {
                        overlayLines(geometry)
                    }
            }
        }
        .padding(.top, 10)
        .frame(width: 262, height: 427)
        .frame(alignment: .leading)
    }
    @ViewBuilder func overlayLines(_ geometry: GeometryProxy) -> some View {
        // 肩膀
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.66, y: geometry.size.height * 0.20),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.00),
            bodyPart: .Deltoids, subPart: BodyPart.DeltoidPart.Acromion.rawValue, value: data.measurements[.Deltoids]![BodyPart.DeltoidPart.Acromion.rawValue]!.value
        )
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.67, y: geometry.size.height * 0.21),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.07),
            bodyPart: .Deltoids, subPart: BodyPart.DeltoidPart.Deltoid.rawValue, value: data.measurements[.Deltoids]![BodyPart.DeltoidPart.Deltoid.rawValue]!.value
        )
        
        // 胸
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.60, y: geometry.size.height * 0.28),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.14),
            bodyPart: .Chest, subPart: BodyPart.ChestPart.Pectoral.rawValue, value: data.measurements[.Chest]![BodyPart.ChestPart.Pectoral.rawValue]!.value
        )
        
        // 手臂
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.73, y: geometry.size.height * 0.28),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.21),
            bodyPart: .Arms, subPart: BodyPart.ArmPart.BicepsTrough.rawValue, value: data.measurements[.Arms]![BodyPart.ArmPart.BicepsTrough.rawValue]!.value
        )
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.73, y: geometry.size.height * 0.33),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.28),
            bodyPart: .Arms, subPart: BodyPart.ArmPart.BicepsPeak.rawValue, value: data.measurements[.Arms]![BodyPart.ArmPart.BicepsPeak.rawValue]!.value
        )
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.77, y: geometry.size.height * 0.38),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.35),
            bodyPart: .Arms, subPart: BodyPart.ArmPart.LowerArm.rawValue, value: data.measurements[.Arms]![BodyPart.ArmPart.LowerArm.rawValue]!.value
        )
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.85, y: geometry.size.height * 0.45),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.42),
            bodyPart: .Arms, subPart: BodyPart.ArmPart.Wrist.rawValue, value: data.measurements[.Arms]![BodyPart.ArmPart.Wrist.rawValue]!.value
        )
        
        // 腰腹
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.53, y: geometry.size.height * 0.40),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.52),
            bodyPart: .Core, subPart: BodyPart.CorePart.UpperWaist.rawValue, value: data.measurements[.Core]![BodyPart.CorePart.UpperWaist.rawValue]!.value
        )
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.53, y: geometry.size.height * 0.45),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.63),
            bodyPart: .Core, subPart: BodyPart.CorePart.LowerWaist.rawValue, value: data.measurements[.Core]![BodyPart.CorePart.LowerWaist.rawValue]!.value
        )
        
        // 大腿
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.60, y: geometry.size.height * 0.55),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.70),
            bodyPart: .Thighs, subPart: BodyPart.ThighsPart.ThighMusclePeak.rawValue, value: data.measurements[.Thighs]![BodyPart.ThighsPart.ThighMusclePeak.rawValue]!.value
        )
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.60, y: geometry.size.height * 0.59),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.77),
            bodyPart: .Thighs, subPart: BodyPart.ThighsPart.Length.rawValue, value: data.measurements[.Thighs]![BodyPart.ThighsPart.Length.rawValue]!.value
        )
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.60, y: geometry.size.height * 0.70),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.84),
            bodyPart: .Thighs, subPart: BodyPart.ThighsPart.Knee.rawValue, value: data.measurements[.Thighs]![BodyPart.ThighsPart.Knee.rawValue]!.value
        )
        
        // 小腿
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.63, y: geometry.size.height * 0.75),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.91),
            bodyPart: .Calves, subPart: BodyPart.CalfPart.CalfMusclePeak.rawValue, value: data.measurements[.Calves]![BodyPart.CalfPart.CalfMusclePeak.rawValue]!.value
        )
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.63, y: geometry.size.height * 0.80),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 0.98),
            bodyPart: .Calves, subPart: BodyPart.CalfPart.Length.rawValue, value: data.measurements[.Calves]![BodyPart.CalfPart.Length.rawValue]!.value
        )
        LineWithPreviewAnnotation(
            start: CGPoint(x: geometry.size.width * 0.63, y: geometry.size.height * 0.90),
            end: CGPoint(x: geometry.size.width + 30, y: geometry.size.height * 1.05),
            bodyPart: .Calves, subPart: BodyPart.CalfPart.Ankle.rawValue, value: data.measurements[.Calves]![BodyPart.CalfPart.Ankle.rawValue]!.value
        )
    }
    
}

#Preview {
    PlayView(previewMode: .constant(true))
        .environmentObject(RecordingViewModel())
}
