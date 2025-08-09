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
        // Calendar 설정 (한국 시간대 기준, 필요에 따라 변경 가능)
        let calendar = Calendar.current
        // baseDate의 주에서 월요일 찾기
        let components = calendar.dateComponents([.year, .month, .day, .weekday], from: baseDate)
        guard let weekday = components.weekday else {
            return ([], [], []) // weekday가 없으면 빈 배열 반환
        }
        // 월요일로부터의 차이 계산 (일요일=1, 월요일=2, ..., 토요일=7)
        let daysFromMonday = weekday == 1 ? 6 : weekday - 2
        guard let mondayOfCurrentWeek = calendar.date(byAdding: .day, value: -daysFromMonday, to: baseDate) else {
            return ([], [], []) // 계산 실패 시 빈 배열 반환
        }
        // 현재 주의 월요일 ~ 일요일
        var currentWeek: [Date] = []
        for dayOffset in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: mondayOfCurrentWeek) {
                currentWeek.append(date)
            }
        }
        // 저번 주의 월요일 (현재 주 월요일 - 7일)
        guard let mondayOfPreviousWeek = calendar.date(byAdding: .day, value: -7, to: mondayOfCurrentWeek) else {
            return ([], [], []) // 계산 실패 시 빈 배열 반환
        }
        // 저번 주의 월요일 ~ 일요일
        var previousWeek: [Date] = []
        for dayOffset in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: mondayOfPreviousWeek) {
                previousWeek.append(date)
            }
        }
        // 다음 주의 월요일 (현재 주 월요일 + 7일)
        guard let mondayOfNextWeek = calendar.date(byAdding: .day, value: 7, to: mondayOfCurrentWeek) else {
            return ([], [], []) // 계산 실패 시 빈 배열 반환
        }
        // 다음 주의 월요일 ~ 일요일
        var nextWeek: [Date] = []
        for dayOffset in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: mondayOfNextWeek) {
                nextWeek.append(date)
            }
        }
        return (previousWeek, currentWeek, nextWeek)
    }
}
