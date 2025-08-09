//
//  CalendarWeekScrollView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/8/25.
//

import SwiftUI
import AlloDomain

/// 주간 스크롤 뷰입니다.
/// 이전, 현재, 다음 주를 가지고 스크롤 완료 시 날짜 데이터를 업데이트 하여 무한 스크롤을 구현합니다
struct CalendarWeekScrollView: View {
    
    /// 캘린더
    let selectedDayOfTheWeek: DayOfTheWeek // 선택한 요일(모든 주에 적용)
    
    /// 이전 주, 현재 주, 다음 주
    let prevWeekDates: [Date: Bool]
    let presentWeekDates: [Date: Bool]
    let nextWeekDates: [Date: Bool]
    
    /// 특정 날짜 선택 시
    let onTap: (Date) -> Void
    
    /// 스크롤 시
    let scrollToPast: () -> Void
    let scrollToFuture: () -> Void
    
    /// 스크롤 뷰 상태 변수
    @Binding var scrollPosition: Int?
    
    /// 양쪽 여백
    let padding: CGFloat = 23.5
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                LazyHStack {
                    CalendarWeekView(
                        selectedDayOfTheWeek: selectedDayOfTheWeek,
                        dates: prevWeekDates,
                        onTap: onTap
                    )
                    .id(-1)
                    CalendarWeekView(
                        selectedDayOfTheWeek: selectedDayOfTheWeek,
                        dates: presentWeekDates,
                        onTap: onTap
                    )
                    .id(0)
                    CalendarWeekView(
                        selectedDayOfTheWeek: selectedDayOfTheWeek,
                        dates: nextWeekDates,
                        onTap: onTap
                    )
                    .id(1)
                }.scrollTargetLayout()
            }
            .scrollPosition(id: $scrollPosition)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
            .onScrollPhaseChange { oldPhase, newPhase, context in
                if newPhase == .idle && oldPhase == .decelerating { // 스크롤 완료 시점
                    let pageWidth = geometry.size.width - padding * 2 // 1주의 양쪽 여백 제외 너비
                    let pageIndex = Int(
                        round(context.geometry.contentOffset.x / (pageWidth + padding * 2))
                    )
                    switch pageIndex {
                    case 0:
                        scrollToPast()
                    case 1:
                        break
                    default:
                        scrollToFuture()
                    }
                }
            }
        }
    }
}
