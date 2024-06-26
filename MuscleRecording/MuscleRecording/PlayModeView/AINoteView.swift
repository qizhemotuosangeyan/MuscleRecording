//
//  AINoteView.swift
//  MuscleRecording
//
//  Created by 千千 on 6/26/24.
//

import SwiftUI

struct AINoteView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Note（AI建议）")
                .font(.title2)
            Text("""
根据世卫组织的定义，身体活动是由骨骼肌肉产生的需要消耗能量的任何身体动作。身体活动是指所有运动，包括闲暇时间的活动，在不同地点之间往返，或作为一个人工作的一部分。中等强度和高强度的身体活动均可增进健康。

流行的活动方式包括步行、骑自行车、轮式运动、体育运动、积极的娱乐和游戏，可以在任何技能级别开展，而且每个人都可以享受。
""")
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 15.0)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        
    }
}

#Preview {
    AINoteView()
}
