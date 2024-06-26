//
//  RecordingViewModel.swift
//  MuscleRecording
//
//  Created by 千千 on 6/25/24.
//

import Foundation

class RecordingViewModel: ObservableObject {
    @Published var measurements: [BodyPart: [String: Measurement]] = [:]
    var bodyDescription: String {
        var bodyDescription = ""
        for (bodyPart, subPartDict) in measurements {
            for str in subPartDict.keys {
                let description1 = "我的"
                let partString = str.bodySubPartTitle(bodyPart: bodyPart)
                let valueString = String(format: "%.1f", measurements[bodyPart]![str]!.value)
                let description2 = "cm,"
                bodyDescription = bodyDescription + description1 + partString + valueString + description2
            }
        }
        let question = "请帮我分析一下身体各个部位的围度，根据平均值分析一下我的身体围度情况，说说我的那些地方比平均值更好，哪些地方比平均值稍差一些，然后指出我应该着重加强那些部位的锻炼，最后能在给出一些推荐的锻炼动作（注意区分居家和健身房）"
        let config = "请对回复进行摘要，控制在150字左右，且10行以内"
        return bodyDescription + question + config
    }
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
