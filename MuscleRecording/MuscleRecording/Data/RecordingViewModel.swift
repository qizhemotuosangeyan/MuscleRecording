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
                BodyPart.DeltoidPart.Acromion.rawValue: Measurement(part: BodyPart.DeltoidPart.Acromion.rawValue, value: 150),
                BodyPart.DeltoidPart.Deltoid.rawValue: Measurement(part: BodyPart.DeltoidPart.Deltoid.rawValue, value: 170)
            ],
            .Chest: [
                BodyPart.ChestPart.Pectoral.rawValue: Measurement(part: BodyPart.ChestPart.Pectoral.rawValue, value: 84)
            ],
            .Arms: [
                BodyPart.ArmPart.BicepsPeak.rawValue: Measurement(part: BodyPart.ArmPart.BicepsPeak.rawValue, value: 45),
                BodyPart.ArmPart.BicepsTrough.rawValue: Measurement(part: BodyPart.ArmPart.BicepsTrough.rawValue, value: 35),
                BodyPart.ArmPart.Wrist.rawValue: Measurement(part: BodyPart.ArmPart.Wrist.rawValue, value: 25),
                BodyPart.ArmPart.LowerArm.rawValue: Measurement(part: BodyPart.ArmPart.LowerArm.rawValue, value: 32)
            ],
            .Core: [
                BodyPart.CorePart.UpperWaist.rawValue: Measurement(part: BodyPart.CorePart.UpperWaist.rawValue, value: 65),
                BodyPart.CorePart.MiddleWaist.rawValue: Measurement(part: BodyPart.CorePart.MiddleWaist.rawValue, value: 70),
                BodyPart.CorePart.LowerWaist.rawValue: Measurement(part: BodyPart.CorePart.LowerWaist.rawValue, value: 74)
            ],
            .Thighs: [
                BodyPart.ThighsPart.ThighMusclePeak.rawValue: Measurement(part: BodyPart.ThighsPart.ThighMusclePeak.rawValue, value: 55),
                BodyPart.ThighsPart.Length.rawValue: Measurement(part: BodyPart.ThighsPart.Length.rawValue, value: 45),
                BodyPart.ThighsPart.Knee.rawValue: Measurement(part: BodyPart.ThighsPart.Knee.rawValue, value: 40)
            ],
            .Calves: [
                BodyPart.CalfPart.CalfMusclePeak.rawValue: Measurement(part: BodyPart.CalfPart.CalfMusclePeak.rawValue, value: 42),
                BodyPart.CalfPart.Length.rawValue: Measurement(part: BodyPart.CalfPart.Length.rawValue, value: 50),
                BodyPart.CalfPart.Ankle.rawValue: Measurement(part: BodyPart.CalfPart.Ankle.rawValue, value: 25)
            ]
        ]
    }
    func updateMeasurement(bodyPart: BodyPart, subPart: String, value: Double) {
        if var partMeasurements = measurements[bodyPart] {
            if var measurement = partMeasurements[subPart] {
                measurement.value = value
                partMeasurements[subPart] = measurement
                measurements[bodyPart] = partMeasurements
            }
        }
    }
}
