//
//  AppBaseData.swift
//  MuscleRecording
//
//  Created by 千千 on 7/2/24.
//

import Foundation

func appName() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
}
