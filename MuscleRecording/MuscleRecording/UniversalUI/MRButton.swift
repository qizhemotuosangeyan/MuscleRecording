//
//  MRButton.swift
//  MuscleRecording
//
//  Created by 千千 on 7/2/24.
//
import SwiftUI

struct MRButton: View {
    let title: String
    let titleColor: Color
    let color: Color
    let action: () -> Void
    let cornerRadius: CGFloat
    @State private var isPressed = false
    
    init(
        title: String = "Press Me",
        titleColor: Color = .white,
        color: Color = .green,
        action: @escaping () -> Void = {},
        cornerRadius: CGFloat = 10
    ) {
        self.title = title
        self.titleColor = titleColor
        self.color = color
        self.action = action
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(color)
                    .cornerRadius(cornerRadius)
                    .shadow(color: .gray, radius: isPressed ? 2 : 6, x: 0, y: isPressed ? 2 : 6)
                    .scaleEffect(isPressed ? 0.95 : 1.0)
                Text(title)
                    .fontWeight(.bold)
                    .foregroundStyle(titleColor)
                    .scaleEffect(isPressed ? 0.95 : 1.0)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        withAnimation {
                            isPressed = true
                        }
                    }
                    .onEnded { _ in
                        // 触觉反馈
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        withAnimation {
                            isPressed = false
                            action()
                        }
                    }
            )
        }
    }
}

#Preview {
    MRButton()
        .frame(width: 300, height: 100)
}
