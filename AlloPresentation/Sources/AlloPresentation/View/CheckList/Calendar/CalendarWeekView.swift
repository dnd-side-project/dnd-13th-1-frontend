//
//  CalendarWeekView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/6/25.
//

import SwiftUI
import AlloDomain

struct CalendarWeekView: View {
    
    
    init(selectedDayOfTheWeek: DayOfTheWeek, dates: [Date : Bool], onTap: @escaping (Date) -> Void) {
        Fonts.registerCustomFonts()
        self.selectedDayOfTheWeek = selectedDayOfTheWeek
        self.dates = dates
        self.onTap = onTap
    }
    
    let selectedDayOfTheWeek: DayOfTheWeek // 선택한 요일
    let dates: [Date: Bool] // [일주일 날짜 데이터 : 집안일 여부 Boolean]
    let onTap: (Date) -> Void // 선택 시
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: (geometry.size.width - 23.5 * 2 - 40 * 7) / 6) {
                ForEach(dates.keys.sorted(), id: \.self) { date in
                    CalendarDayView(
                        dayOfTheWeek: date.getDayOfTheWeek().rawValue,
                        day: date.getDay(),
                        isSelected: date.getDayOfTheWeek() == selectedDayOfTheWeek,
                        hasTask: dates[date] ?? false
                    ).onTapGesture {
                        onTap(date)
                    }
                }
            }.padding(.horizontal, 23.5)
        }
    }
    
}
