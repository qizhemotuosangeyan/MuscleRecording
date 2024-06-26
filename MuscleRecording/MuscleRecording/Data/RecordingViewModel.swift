//
//  RecordingViewModel.swift
//  MuscleRecording
//
//  Created by 千千 on 6/25/24.
//

import Foundation

class RecordingViewModel: ObservableObject {
    @Published var measurements: [BodyPart: [String: Measurement]] = [:]
    
    init() {
        // Initialize with default values
        measurements = [
            .Deltoids: [
                BodyPart.DeltoidPart.Acromion.rawValue: Measurement(value: 150),
                BodyPart.DeltoidPart.Deltoid.rawValue: Measurement(value: 170)
            ],
            .Chest: [
                BodyPart.ChestPart.Pectoral.rawValue: Measurement(value: 84)
            ],
            .Arms: [
                BodyPart.ArmPart.BicepsPeak.rawValue: Measurement(value: 45),
                BodyPart.ArmPart.BicepsTrough.rawValue: Measurement(value: 35),
                BodyPart.ArmPart.Wrist.rawValue: Measurement(value: 25),
                BodyPart.ArmPart.LowerArm.rawValue: Measurement(value: 32)
            ],
            .Core: [
                BodyPart.CorePart.UpperWaist.rawValue: Measurement(value: 65),
//                BodyPart.CorePart.MiddleWaist.rawValue: Measurement(value: 70),
                BodyPart.CorePart.LowerWaist.rawValue: Measurement(value: 74)
            ],
            .Thighs: [
                BodyPart.ThighsPart.ThighMusclePeak.rawValue: Measurement(value: 55),
                BodyPart.ThighsPart.Length.rawValue: Measurement(value: 45),
                BodyPart.ThighsPart.Knee.rawValue: Measurement(value: 40)
            ],
            .Calves: [
                BodyPart.CalfPart.CalfMusclePeak.rawValue: Measurement(value: 42),
                BodyPart.CalfPart.Length.rawValue: Measurement(value: 50),
                BodyPart.CalfPart.Ankle.rawValue: Measurement(value: 25)
            ]
        ]
    }
}
