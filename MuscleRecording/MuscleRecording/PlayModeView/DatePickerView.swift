//
//  DatePickerView.swift
//  MuscleRecording
//
//  Created by 千千 on 6/26/24.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var isPresented: Bool
    @Binding var remindDate: Date
    @State var previewDate = Date.now
    @Binding var willRequestPermission: Bool

    var closedRange: ClosedRange<Date> {
        return Date.now ... Date.now.addingTimeInterval(86400 * 30 * 24)
    }
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Cancel")
                    .contentShape(Rectangle())
                    .onHapticTapGesture {
                        isPresented = false
                    }
                Spacer()
                Text("Add")
                    .contentShape(Rectangle())
                    .onHapticTapGesture {
                        remindDate = previewDate
                        isPresented = false
                        willRequestPermission = true
                    }
            }
            .foregroundStyle(.blue)
            DatePicker(selection: $previewDate, in: closedRange, displayedComponents: [.date]) {
            }
            .datePickerStyle(GraphicalDatePickerStyle())
            DatePicker(selection: $previewDate, in: closedRange, displayedComponents: [ .hourAndMinute]) {
                Text("Time")
            }
        }
        .onAppear {
            previewDate = remindDate
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

    }
    

    

}

#Preview {
    DatePickerView(isPresented: .constant(true), remindDate: .constant(.now), willRequestPermission: .constant(false))
}
