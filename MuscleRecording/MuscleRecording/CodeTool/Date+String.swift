//
//  Date+String.swift
//  MuscleRecording
//
//  Created by 千千 on 6/26/24.
//

import Foundation

extension Date {
    func toMDString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M月d日"
        return formatter.string(from: self)
    }
    func toYYMMDDServerString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: self)
    }
}
