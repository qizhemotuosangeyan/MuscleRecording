//
//  String+BodySubPart.swift
//  MuscleRecording
//
//  Created by 千千 on 6/26/24.
//

import Foundation
extension String {
    func bodySubPartTitle(bodyPart: BodyPart) -> String {
        switch bodyPart {
        case .Deltoids:
            return BodyPart.DeltoidPart(rawValue: self)!.title
        case .Chest:
            return BodyPart.ChestPart(rawValue: self)!.title
        case .Arms:
            return BodyPart.ArmPart(rawValue: self)!.title
        case .Core:
            return BodyPart.CorePart(rawValue: self)!.title
        case .Thighs:
            return BodyPart.ThighsPart(rawValue: self)!.title
        case .Calves:
            return BodyPart.CalfPart(rawValue: self)!.title
        }
    }
}
