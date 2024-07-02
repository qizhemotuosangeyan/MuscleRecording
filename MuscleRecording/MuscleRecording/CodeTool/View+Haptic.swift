//
//  View+Haptic.swift
//  MuscleRecording
//
//  Created by 千千 on 7/2/24.
//

import Foundation
import SwiftUI

struct HapticTapGesture: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onTapGesture {
                // 触发震动反馈
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()

                // 执行传入的动作
                action()
            }
    }
}

extension View {
    func onHapticTapGesture(action: @escaping () -> Void) -> some View {
        self.modifier(HapticTapGesture(action: action))
    }
}
