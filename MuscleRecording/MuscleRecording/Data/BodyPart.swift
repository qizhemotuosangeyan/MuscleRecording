//
//  BodyPart.swift
//  MuscleRecording
//
//  Created by 千千 on 6/25/24.
//

import Foundation

enum BodyPart: String, CaseIterable, Identifiable {
    case Deltoids //肩膀
    case Chest // 胸
    case Arms // 手臂
    case Core // 腰腹
    case Thighs // 大腿
    case Calves // 小腿
    var id: Self { self }
    
    var title: String {
        switch self {
        case .Deltoids: return NSLocalizedString("肩膀", comment: "")
        case .Chest: return NSLocalizedString("胸", comment: "")
        case .Arms: return NSLocalizedString("手臂", comment: "")
        case .Core: return NSLocalizedString("腰腹", comment: "")
        case .Thighs: return NSLocalizedString("大腿", comment: "")
        case .Calves: return NSLocalizedString("小腿", comment: "")
        }
    }
    
    enum DeltoidPart: String, CaseIterable, Identifiable {
        case Acromion // 肩峰
        case Deltoid // 三角肌峰
        var id: Self { self }
        var title: String {
            switch self {
            case .Acromion: return NSLocalizedString("肩峰", comment: "")
            case .Deltoid: return NSLocalizedString("三角肌峰", comment: "")
            }
        }
        var description: String {
            switch self {
            case .Acromion: return NSLocalizedString("肩峰宽度指的是从一侧肩峰到另一侧肩峰的宽度。测量时，请站直并保持自然姿势。", comment: "")
            case .Deltoid: return NSLocalizedString("三角肌峰宽度指的是肩部三角肌最宽处的宽度。测量时，请站直并保持自然姿势，测量三角肌最突出的部分。", comment: "")
            }
        }
    }

    enum ChestPart: String, CaseIterable, Identifiable {
        case Pectoral // 胸大肌
        var id: Self { self }
        var title: String {
            switch self {
            case .Pectoral: return NSLocalizedString("胸大肌", comment: "")
            }
        }
        var description: String {
            switch self {
            case .Pectoral: return NSLocalizedString("胸大肌宽度指的是胸部最宽处的宽度。测量时，请保持自然呼吸状态，不要刻意吸气或呼气。", comment: "")
            }
        }
    }
    
    enum ArmPart: String, CaseIterable, Identifiable {
        case BicepsPeak // 肱二头肌峰
        case BicepsTrough // 肱二头肌谷
        case Wrist // 手腕
        case LowerArm // 小臂
        var id: Self { self }
        var title: String {
            switch self {
            case .BicepsPeak: return NSLocalizedString("肱二头肌峰", comment: "")
            case .BicepsTrough: return NSLocalizedString("肱二头肌谷", comment: "")
            case .Wrist: return NSLocalizedString("手腕", comment: "")
            case .LowerArm: return NSLocalizedString("小臂", comment: "")
            }
        }
        var description: String {
            switch self {
            case .BicepsPeak: return NSLocalizedString("肱二头肌峰宽度指的是肱二头肌最宽处的宽度。测量时，请弯曲手臂并使肌肉紧绷。", comment: "")
            case .BicepsTrough: return NSLocalizedString("肱二头肌谷宽度指的是肱二头肌最窄处的宽度。测量时，请放松手臂。", comment: "")
            case .Wrist: return NSLocalizedString("手腕宽度指的是手腕最窄处的宽度。测量时，请保持手腕自然放松状态。", comment: "")
            case .LowerArm: return NSLocalizedString("小臂宽度指的是小臂最宽处的宽度。测量时，请放松手臂并保持自然姿势。", comment: "")
            }
        }
        
    }
    
    enum CorePart: String, CaseIterable, Identifiable {
        case UpperWaist // 上腰围
        case MiddleWaist // 中腰围
        case LowerWaist // 下腰围
        var id: Self { self }
        var title: String {
            switch self {
            case .UpperWaist: return NSLocalizedString("上腰围", comment: "")
            case .MiddleWaist: return NSLocalizedString("中腰围", comment: "")
            case .LowerWaist: return NSLocalizedString("下腰围", comment: "")
            }
        }
        var description: String {
            switch self {
            case .UpperWaist: return NSLocalizedString("上腰围指的是腰部上方最细处的周长。测量时，请保持自然呼吸状态，不要刻意吸气或呼气。", comment: "")
            case .MiddleWaist: return NSLocalizedString("中腰围指的是腰部中间最细处的周长。测量时，请保持自然呼吸状态，不要刻意吸气或呼气。", comment: "")
            case .LowerWaist: return NSLocalizedString("下腰围指的是腰部下方最细处的周长。测量时，请保持自然呼吸状态，不要刻意吸气或呼气。", comment: "")
            }
        }
    }
    
    enum ThighsPart: String, CaseIterable, Identifiable {
        case ThighMusclePeak // 大腿肌峰
        case Length // 大腿长度
        case Knee // 膝盖
        var id: Self { self }
        var title: String {
            switch self {
            case .ThighMusclePeak: return NSLocalizedString("大腿肌峰", comment: "")
            case .Length: return NSLocalizedString("大腿长度", comment: "")
            case .Knee: return NSLocalizedString("膝盖", comment: "")
            }
        }
        var description: String {
            switch self {
            case .ThighMusclePeak: return NSLocalizedString("大腿肌峰宽度指的是大腿最宽处的宽度。测量时，请站直并保持自然姿势。", comment: "")
            case .Length: return NSLocalizedString("大腿长度指的是从臀部到膝盖的长度。测量时，请站直并保持自然姿势。", comment: "")
            case .Knee: return NSLocalizedString("膝盖宽度指的是膝盖最宽处的宽度。测量时，请站直并保持自然姿势。", comment: "")
            }
        }

    }
    
    enum CalfPart: String, CaseIterable, Identifiable {
        case CalfMusclePeak // 小腿肌峰
        case Length // 小腿长度
        case Ankle // 脚踝
        var id: Self { self }
        var title: String {
            switch self {
            case .CalfMusclePeak: return NSLocalizedString("小腿肌峰", comment: "")
            case .Length: return NSLocalizedString("小腿长度", comment: "")
            case .Ankle: return NSLocalizedString("脚踝", comment: "")
            }
        }
        var description: String {
            switch self {
            case .CalfMusclePeak: return NSLocalizedString("小腿肌峰宽度指的是小腿最宽处的宽度。测量时，请站直并保持自然姿势。", comment: "")
            case .Length: return NSLocalizedString("小腿长度指的是从膝盖到脚踝的长度。测量时，请站直并保持自然姿势。", comment: "")
            case .Ankle: return NSLocalizedString("脚踝宽度指的是脚踝最窄处的宽度。测量时，请保持自然放松状态。", comment: "")
            }
        }
    }
}

struct Measurement {
    let part: String
    var value: Double // 单位cm
    var range = 10...200.0
}

