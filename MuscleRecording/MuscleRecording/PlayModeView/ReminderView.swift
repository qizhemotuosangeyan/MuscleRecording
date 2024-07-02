//
//  ReminderView.swift
//  MuscleRecording
//
//  Created by 千千 on 6/26/24.
//

import SwiftUI

struct ReminderView: View {
    @State var isReminderOn = false
    @State var isDatePickerSheetVisible = false
    @State var remindDate: Date = Date.now.addingTimeInterval(86400 * 30)
    @State var nextRemindTimeOKAlert = false
    @State var willRequestPermission = false
    @State var nextRemindTimeFaliureAlert = false
    let clockSize = CGFloat(26)
    var body: some View {
        HStack {
            if isReminderOn {
                Image(systemName: "clock.badge.checkmark")
                    .font(.system(size: clockSize))
                    .foregroundStyle(.green)
            } else {
                Image(systemName: "clock.badge.exclamationmark")
                    .font(.system(size: clockSize))
                    .foregroundStyle(.orange)
            }
            Text("下次提醒时间: ")
            Text(remindDate.toMDString())
                .foregroundStyle(.blue)
        }
        .contentShape(Rectangle())
        .onHapticTapGesture {
            isDatePickerSheetVisible.toggle()
        }
        .sheet(isPresented: $isDatePickerSheetVisible, onDismiss: {
            // 收起来之后看看用户是否点击确定，是的话就请求权限
            if willRequestPermission {
                NotificationManager.shared.requestNotificationPermission { granted in
                    if granted {
                        // 已授权
                        NotificationManager.shared.scheduleNotification(at: remindDate) { ok in
                            if ok {
                                // 添加成功
                                isReminderOn = true
                                nextRemindTimeOKAlert = true
                            } else {
                                print("授权成功但提醒添加失败？")                                
                            }
                        }
                        nextRemindTimeOKAlert.toggle()
                    } else {
                        // 用户未授权则显示红色闹钟
                        isReminderOn = false
                        nextRemindTimeFaliureAlert = true
                    }
                    
                }
                willRequestPermission = false
            }
        }, content: {
            DatePickerView(isPresented: $isDatePickerSheetVisible, remindDate: $remindDate, willRequestPermission: $willRequestPermission)
                .presentationDetents([.medium])
        })
        .alert("✅下次提醒时间已经设置好了💪", isPresented: $nextRemindTimeOKAlert) {
            // 用户点击了确认
        }
        .alert("❌设置失败，请检查权限", isPresented: $nextRemindTimeFaliureAlert) {
            // 设置失败弹窗
        }
        .onAppear {
            NotificationManager.shared.requestNotificationPermission { granted in
                if granted {
                    NotificationManager.shared.checkNotificationExists { exists in
                        if exists {
                            isReminderOn = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ReminderView()
}
