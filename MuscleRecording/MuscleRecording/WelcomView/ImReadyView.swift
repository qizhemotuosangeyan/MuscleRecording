//
//  ImReadyView.swift
//  MuscleRecording
//
//  Created by 千千 on 7/2/24.
//

import SwiftUI

struct ImReadyView: View {
    @AppStorage("ImReady") private var ImReadyButtonClicked: Bool = false
    var body: some View {
        VStack(alignment: .center) {
            
            VStack(alignment: .leading) {
                Text("首先，请准备一个软尺\n\n\n")
                    .addOpacityAndOffsetAnimation(appearAfter: 0, animateDuration: 1.0)
                Text("他大概长这样\n或者你有其他尺子也可以(总之不要弄伤你自己就好啦)")
                    .addOpacityAndOffsetAnimation(appearAfter: 1.5, animateDuration: 1.0)
                Image(ImageResource.softRuler)
                    .resizable()
                    .scaledToFit()
                    .addOpacityAndOffsetAnimation(appearAfter: 3.0, animateDuration: 1.0)
                Text("如果手边没有的话，可以先去购物软件下单，准备好了再来这里，我们在这边等你～\n\n\n")
                    .addOpacityAndOffsetAnimation(appearAfter: 4.5, animateDuration: 1.0)
                Text("全程可以一个人独立完成，当然如果有搭子一起的话也会更方便些～\n\n\n\n")
                    .addOpacityAndOffsetAnimation(appearAfter: 6, animateDuration: 1.0)
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            VStack {
                MRButton(title: "I'm Ready") {
                    ImReadyButtonClicked = true
                }
                .padding(.horizontal, 25)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    ImReadyView()
}
