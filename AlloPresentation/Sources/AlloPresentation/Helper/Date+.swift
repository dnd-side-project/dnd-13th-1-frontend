//
//  Date+.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/8/25.
//

import Foundation
import AlloDomain

extension Date {
    /// 해당 날짜가 그 달의 며칠인지를 반환합니다
    func getDay() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        return components.day ?? 1
    }
    
    /// 해당 날짜의 요일을 반환합니다
    func getDayOfTheWeek() -> DayOfTheWeek {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        
        guard let weekday = components.weekday else { return .sunday }
        
        switch weekday {
        case 1: return .sunday
        case 2: return .monday
        case 3: return .tuesday
        case 4: return .wednesday
        case 5: return .thursday
        case 6: return .friday
        case 7: return .saturday
        default: return .sunday
        }
    }
}
