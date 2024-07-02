//
//  RecordingViewModel.swift
//  MuscleRecording
//
//  Created by 千千 on 6/25/24.
//
import Foundation
import CoreData
import SwiftUI

class RecordingViewModel: ObservableObject {
    @Published var measurements: [BodyPart: [String: Measurement]] = [:]
    private var viewContext: NSManagedObjectContext

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
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        loadMeasurements()
    }
    
    private func loadMeasurements() {
        let fetchRequest: NSFetchRequest<UserBody> = UserBody.fetchRequest()
        
        do {
            let userBodies = try viewContext.fetch(fetchRequest)
            for userBody in userBodies {
                // 用每一个记录都去匹配BodyPart
                if let deltoidsPart = BodyPart.DeltoidPart(rawValue: userBody.part!) {
                    // 是一个肩部part
                    if measurements[.Deltoids] == nil {
                        measurements[.Deltoids] = [:]
                    }
                    measurements[.Deltoids]?[userBody.part!] = Measurement(value: userBody.value)
                } else if let chestPart = BodyPart.ChestPart(rawValue: userBody.part!) {
                    // 是一个胸部part
                    if measurements[.Chest] == nil {
                        measurements[.Chest] = [:]
                    }
                    measurements[.Chest]?[userBody.part!] = Measurement(value: userBody.value)
                } else if let armPart = BodyPart.ArmPart(rawValue: userBody.part!) {
                    // 是一个胳膊部part
                    if measurements[.Arms] == nil {
                        measurements[.Arms] = [:]
                    }
                    measurements[.Arms]?[userBody.part!] = Measurement(value: userBody.value)
                } else if let corePart = BodyPart.CorePart(rawValue: userBody.part!) {
                    // 是一个腰腹part
                    if measurements[.Core] == nil {
                        measurements[.Core] = [:]
                    }
                    measurements[.Core]?[userBody.part!] = Measurement(value: userBody.value)
                } else if let thighsPart = BodyPart.ThighsPart(rawValue: userBody.part!) {
                    // 是一个大腿part
                    if measurements[.Thighs] == nil {
                        measurements[.Thighs] = [:]
                    }
                    measurements[.Thighs]?[userBody.part!] = Measurement(value: userBody.value)
                } else if let calfPart = BodyPart.CalfPart(rawValue: userBody.part!) {
                    // 是一个小腿部part
                    if measurements[.Calves] == nil {
                        measurements[.Calves] = [:]
                    }
                    measurements[.Calves]?[userBody.part!] = Measurement(value: userBody.value)
                } else {
                    print("无法识别的 part: \(userBody.part!)")
                }
            }
        } catch {
            print("Failed to fetch UserBody: \(error.localizedDescription)")
        }
    }
    
    func saveMeasurement(for bodyPart: BodyPart, partName: String, value: Float) {
        let newUserBody = UserBody(context: viewContext)
        newUserBody.part = partName
        newUserBody.timeStamp = Date()
        newUserBody.value = value
        
        if measurements[bodyPart] == nil {
            measurements[bodyPart] = [:]
        }
        measurements[bodyPart]?[partName] = Measurement(value: value)
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save UserBody: \(error.localizedDescription)")
        }
    }
}
