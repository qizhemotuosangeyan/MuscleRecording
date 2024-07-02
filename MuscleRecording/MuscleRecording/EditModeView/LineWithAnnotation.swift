//
//  LineWithAnnotation.swift
//  MuscleRecording
//
//  Created by 千千 on 6/25/24.
//

import SwiftUI

struct LineWithAnnotation: View {
    let start: CGPoint
    let end: CGPoint
    // 注释的引线总是从图片上的某个点指向注释的文本
    // 注释的引线总是先走一段斜线，后走剩下半段水平线
    
    // 拐点比例：起点和终点水平方向上的拐点比例，范围从0-1。
    // 0表示先竖直方向再水平方向。
    // 1表示不拐弯，直接亮点连线
    let bodyType: BodyPart
    var inflexionPointRatio = 0.4
    var highlighted: Bool {
        return bodyType == self.picked
    }
    @State private var isPressed = false
    @Binding var picked: BodyPart
    var body: some View {
        // 引线
        Path { path in
            path.move(to: start)
            path.addLine(to: calcMiddlePoint())
            path.addLine(to: end)
        }
        .stroke(Color.gray, lineWidth: 2)
        
        // 注释文字
        Text(bodyType.title)
            .background(highlighted ? Color.green : Color.white)
            .padding(4)
            .cornerRadius(5)
            .shadow(radius: isPressed ? 0 : 5)
            .position(x: end.x, y: end.y)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        withAnimation {
                            isPressed = true
                        }
                        // 触觉反馈
                    }
                    .onEnded { _ in
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        withAnimation {
                            isPressed = false
                            self.picked = bodyType
                        }
                    }
            )
        
    }
    func calcMiddlePoint() -> CGPoint {
        let middleX = start.x + (end.x - start.x) * CGFloat(inflexionPointRatio)
        return CGPoint(x: middleX, y: end.y)
    }
    
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    return RecordingView(previewMode: .constant(false))
        .environmentObject(RecordingViewModel(context: context))
}
