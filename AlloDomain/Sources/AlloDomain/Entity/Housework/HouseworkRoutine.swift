//
//  HouseworkRoutine.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/9/25.
//

import Foundation

public enum HouseworkRoutine: String, CaseIterable, Sendable {
    case none = "반복안함"
    case everyday = "매일"
    case everyWeek = "매주"
    case biweek = "격주"
}
