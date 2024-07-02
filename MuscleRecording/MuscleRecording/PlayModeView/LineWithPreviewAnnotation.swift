//
//  LineWithPreviewAnnotation.swift
//  MuscleRecording
//
//  Created by 千千 on 6/26/24.
//

import SwiftUI

struct LineWithPreviewAnnotation: View {
    let start: CGPoint
    let end: CGPoint
    // 注释的引线总是从图片上的某个点指向注释的文本
    // 注释的引线总是先走一段斜线，后走剩下半段水平线
    
    // 拐点比例：起点和终点水平方向上的拐点比例，范围从0-1。
    // 0表示先竖直方向再水平方向。
    // 1表示不拐弯，直接亮点连线
    let bodyPart: BodyPart
    let subPart: String
    var inflexionPointRatio = 0.4
    let value: Float
    var body: some View {
        // 引线
        Path { path in
            path.move(to: start)
            path.addLine(to: calcMiddlePoint())
            path.addLine(to: end)
        }
        .stroke(Color.gray, lineWidth: 2)
        
        // 注释文字
        Text(calcAnnotationString())
            .background(Color.white)
            .padding(4)
            .cornerRadius(5)
            .shadow(radius: 5)
            .position(x: end.x, y: end.y)
    }
    func calcAnnotationString() -> String {
        let titleString = subPart.bodySubPartTitle(bodyPart: bodyPart)
        let common = ":"
        let valueString = String(format: "%.1f", value)
        return titleString + common + valueString
    }
    func calcMiddlePoint() -> CGPoint {
        let middleX = start.x + (end.x - start.x) * CGFloat(inflexionPointRatio)
        return CGPoint(x: middleX, y: end.y)
    }
}

#Preview {
    PlayBodyView()
}
