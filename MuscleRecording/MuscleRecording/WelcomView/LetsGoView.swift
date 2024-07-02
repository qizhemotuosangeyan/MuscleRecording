//
//  LetsGoView.swift
//  MuscleRecording
//
//  Created by 千千 on 7/2/24.
//

import SwiftUI

struct LetsGoView: View {
    @State private var muscle2Offset = 0.0
    @State private var muscle2Opacity = 0.0
    @State private var muscle3Offset = 20.0
    @AppStorage("LetsGo") private var letsGoButtonClicked: Bool = false

    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("几天不见，又变大了，朋友\n\n\n")
                    .addOpacityAndOffsetAnimation(appearAfter: 0, animateDuration: 1.0)
                Text("欢迎来到\(appName())\n\n\n")
                    .addOpacityAndOffsetAnimation(appearAfter: 1.5, animateDuration: 1.0)
                Text("让我们一起\n记录下现在的围度\n\n\n")
                    .addOpacityAndOffsetAnimation(appearAfter: 3.0, animateDuration: 1.0)
                Text("相信每个30天\n都会有不一样的变化\n\n\n\n")
                    .addOpacityAndOffsetAnimation(appearAfter: 4.5, animateDuration: 1.0)
                ZStack {
                    Text("💪")
                    //                    .background(.blue)
                        .addOpacityAndOffsetAnimation(appearAfter: 6, animateDuration: 1.0)
                    Text("💪")
                    //                    .background(.green)
                        .instantAppearAfter(delay: 7.1)
                        .offset(x: muscle2Offset)
                        .onAppear {
                            withAnimation(.easeOut(duration: 1).delay(7.1)) {
                                muscle2Offset = 20
                            }
                        }
                        .shakeAndGrow(delay: 8.1, finalScale: 3.0)
                    Text("💪")
                    //                    .background(.red)
                        .instantAppearAfter(delay: 8.6)
                        .offset(x: muscle3Offset)
                        .scaleEffect(3.0)
                        .onAppear {
                            withAnimation(.easeOut(duration: 1).delay(8.6)) {
                                muscle3Offset = 35
                            }
                        }
                        .shakeAndGrow(delay: 9.6, finalScale: 1.5)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            VStack {
                MRButton(title: "Let's Go") {
                    letsGoButtonClicked = true
                }
                    .padding(.horizontal, 25)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
struct OpacityAndOffsetAnimation: ViewModifier {
    @State private var xOffset: CGFloat
    @State private var yOffset: CGFloat
    @State private var opacity: Double
    let delay: Double
    let duration: Double
    
    init(xOffset: CGFloat, yOffset: CGFloat, delay: Double, opacity: Double, animateDuration: Double) {
        _xOffset = State(initialValue: xOffset)
        _yOffset = State(initialValue: yOffset)
        _opacity = State(initialValue: opacity)
        duration = animateDuration
        self.delay = delay
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: xOffset, y: yOffset)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeOut(duration: duration).delay(delay)) {
                    yOffset = 0
                    xOffset = 0
                    opacity = 1
                }
            }
    }
}
struct InstantAppearAnimation: ViewModifier {
    @State private var opacity: Double = 0.0
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    opacity = 1.0
                }
            }
    }
}

extension View {
    func addOpacityAndOffsetAnimation(appearAfter second: Double, animateDuration: Double = 1.0, xOffset: CGFloat = 0, yOffset: CGFloat = 30, opacity: Double = 0.0) -> some View {
        self.modifier(OpacityAndOffsetAnimation(xOffset: xOffset, yOffset: yOffset, delay: second, opacity: opacity, animateDuration: animateDuration))
    }
    func instantAppearAfter(delay: Double) -> some View {
        self.modifier(InstantAppearAnimation(delay: delay))
    }
    func shakeAndGrow(delay: Double, finalScale: Double) -> some View {
        self.modifier(ShakeAndGrowAnimation(delay: delay, finalScale: finalScale))
    }
}
#Preview {
    LetsGoView()
}

struct ShakeAndGrowAnimation: ViewModifier {
    @State private var offset: CGFloat = 0
    @State private var scale: CGFloat = 1.0
    let delay: Double
    let shakeDuration = 0.1
    let shakeOffset = -5.0
    let finalScale: Double
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.easeInOut(duration: shakeDuration).delay(delay)) {
                    offset = shakeOffset
                }
                withAnimation(.easeInOut(duration: shakeDuration).delay(delay + shakeDuration)) {
                    offset = 0
                }
                withAnimation(.easeInOut(duration: shakeDuration).delay(delay + shakeDuration * 2)) {
                    offset = shakeOffset
                }
                withAnimation(.easeInOut(duration: shakeDuration).delay(delay + shakeDuration * 3)) {
                    offset = 0
                    scale = finalScale
                }
            }
    }
}
