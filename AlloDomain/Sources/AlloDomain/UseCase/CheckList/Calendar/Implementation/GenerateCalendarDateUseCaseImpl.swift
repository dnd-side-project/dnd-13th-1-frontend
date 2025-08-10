//
//  GenerateCalendarDateUseCaseImpl.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/9/25.
//

import Foundation

/// 프로토콜의 구현체는 외부 모듈로부터 숨깁니다
/// - Note: Swift에선 접근제어자를 생략해도 internal이 기본 적용됩니다
/// Internal은 같은 모듈(패키지) 내에서만 접근 가능합니다
final class GenerateCalendarDateUseCaseImpl: GenerateCalendarDateUseCase {
    func execute(_ baseDate: Date) -> (previousWeek: [Date], currentWeek: [Date], nextWeek: [Date]) {
        let calendar = Calendar.current
        /// baseDate의 주에서 월요일 찾기
        guard let weekday = calendar.dateComponents([.weekday], from: baseDate).weekday,
              let mondayOfCurrentWeek = calendar.date(byAdding: .day, value: -(weekday == 1 ? 6 : weekday - 2), to: baseDate)
        else {
            return ([], [], [])
        }
        /// 현재 주, 이전 주, 다음 주 생성
        let currentWeek = generateWeek(from: mondayOfCurrentWeek, using: calendar)
        let previousWeek = generateWeek(from: adding(mondayOfCurrentWeek, days: -7), using: calendar)
        let nextWeek = generateWeek(from: adding(mondayOfCurrentWeek, days: +7), using: calendar)
        
        return (previousWeek, currentWeek, nextWeek)
    }
}

private extension GenerateCalendarDateUseCaseImpl {
    func generateWeek(from monday: Date, using calendar: Calendar) -> [Date] {
        (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: monday) }
    }
    /// days 만큼 날짜를 이동합니다
    func adding(_ date: Date, days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: date) ?? date
    }
}
