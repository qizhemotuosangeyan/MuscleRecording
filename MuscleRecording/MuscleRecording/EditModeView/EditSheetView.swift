//
//  EditSheetView.swift
//  MuscleRecording
//
//  Created by 千千 on 6/25/24.
//

import SwiftUI

struct EditSheetView: View {
    @Binding var measurement: Measurement
    @EnvironmentObject var data: RecordingViewModel

    var descriptionText: String {
        switch measurement.bodyPart {
        case .Deltoids:
            return BodyPart.DeltoidPart(rawValue: measurement.subPart)?.description ?? ""
        case .Chest:
            return BodyPart.ChestPart(rawValue: measurement.subPart)?.description ?? ""
        case .Arms:
            return BodyPart.ArmPart(rawValue: measurement.subPart)?.description ?? ""
        case .Core:
            return BodyPart.CorePart(rawValue: measurement.subPart)?.description ?? ""
        case .Thighs:
            return BodyPart.ThighsPart(rawValue: measurement.subPart)?.description ?? ""
        case .Calves:
            return BodyPart.CalfPart(rawValue: measurement.subPart)?.description ?? ""
        }
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(measurement.bodyPart.title)
            Rectangle().foregroundStyle(.white).border(.gray).frame(width: .infinity, height: 150)
            Text(descriptionText)
            HStack(alignment: .bottom) {
                Spacer()
                Text(String(format: "%.1f", measurement.value)).font(.title)
                Text("cm").font(.subheadline)
                Spacer()
            }
        }
        .padding(.horizontal, 20)
    }
}


#Preview {
    EditSheetView(measurement: .constant(Measurement(bodyPart: .Arms, subPart: BodyPart.ArmPart.BicepsPeak.rawValue, value: 150)))
        .environmentObject(RecordingViewModel())
}
