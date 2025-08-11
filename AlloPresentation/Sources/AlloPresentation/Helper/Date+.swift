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
    /// 해당 날짜가 속한 주를 "n월 n째 주" 형태로 반환합니다
    func getWeekString() -> String {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let weekOfMonth = calendar.component(.weekOfMonth, from: self)
        let weekString: String
        switch weekOfMonth {
        case 1: weekString = "첫"
        case 2: weekString = "둘"
        case 3: weekString = "셋"
        case 4: weekString = "넷"
        case 5: weekString = "다섯"
        case 6: weekString = "여섯"
        default: weekString = "\(weekOfMonth)"
        }
        return "\(month)월 \(weekString)째 주"
    }
    /// days 만큼 날짜를 이동합니다
    func adding(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
}
