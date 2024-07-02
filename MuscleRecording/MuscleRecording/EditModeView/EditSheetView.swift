//
//  EditSheetView.swift
//  MuscleRecording
//
//  Created by 千千 on 6/25/24.
//

import SwiftUI

struct EditSheetView: View {
    var bodyPart: BodyPart
    var subPart: String
    @State var sliderValue = 0.0
    @Binding var choosingSubPart: String?
    @EnvironmentObject var data: RecordingViewModel
    var descriptionText: String {
        switch bodyPart {
        case BodyPart.Deltoids:
            return BodyPart.DeltoidPart(rawValue: subPart)!.description
        case BodyPart.Chest:
            return BodyPart.ChestPart(rawValue: subPart)!.description
        case BodyPart.Arms:
            return BodyPart.ArmPart(rawValue: subPart)!.description
        case BodyPart.Core:
            return BodyPart.CorePart(rawValue: subPart)!.description
        case BodyPart.Thighs:
            return BodyPart.ThighsPart(rawValue: subPart)!.description
        case BodyPart.Calves:
            return BodyPart.CalfPart(rawValue: subPart)!.description
        }
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(subPart.bodySubPartTitle(bodyPart: bodyPart))
                Spacer()
                Text("add")
                    .foregroundStyle(.blue)
                    .onHapticTapGesture {
                        data.saveMeasurement(for: bodyPart, partName: subPart, value: Float(sliderValue))
                        choosingSubPart = nil
                    }
            }
            Rectangle().foregroundStyle(.white).border(.gray).frame(height: 150).frame(maxWidth: .infinity)
            Text(descriptionText)
            HStack(alignment: .bottom) {
                Spacer()
                Text(String(format: "%.1f", sliderValue)).font(.title)
                Text("cm").font(.subheadline)
                Spacer()
            }
            Slider(value: $sliderValue, in: data.measurements[bodyPart]?[subPart]?.range ?? 10...200.0, step: 0.1)
            .onChange(of: sliderValue) {
                
            }
        }
        .padding(20)
        .onAppear {
            sliderValue = Double(data.measurements[bodyPart]?[subPart]?.value ?? 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    func sliderRange(_ initialValue: Double) -> ClosedRange<Double> {
        return initialValue - 100 ... initialValue + 100
    }
}


#Preview {
    let context = PersistenceController.shared.container.viewContext
    return EditSheetView(bodyPart: BodyPart.Arms, subPart: BodyPart.ArmPart.BicepsPeak.rawValue, choosingSubPart: .constant(BodyPart.ArmPart.BicepsPeak.rawValue))
        .environmentObject(RecordingViewModel(context: context))
}
