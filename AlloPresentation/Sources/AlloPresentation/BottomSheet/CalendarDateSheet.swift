//
//  CalendarDateSheet.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/17/25.
//
import SwiftUI

public struct CalendarDateSheet: View {
    var dateClickAction: (String) -> Void
    
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var currentMonth: Date = Date()
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let weekdays = ["일","월","화","수","목","금","토"]
    
    public init(dateClickAction: @escaping (String) -> Void) {
        self.dateClickAction = dateClickAction
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .fill(.gray200)
                .frame(width: 40, height: 4)
            
            ZStack {
                Text("마감일 설정")
                    .font(.subtitle1)
                    .foregroundColor(.gray900)
                    .padding(.top, 15)
                    .padding(.bottom, 30)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // 버튼 눌렀을 때 동작
                        if let start = startDate, let end = endDate {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            //dateClickAction("\(formatter.string(from: start)) ~ \(formatter.string(from: end))")
                        }
                    }) {
                        Text("완료")
                            .font(.button1)
                            .foregroundColor(.white)
                            .frame(width: 52, height: 32)
                            .background(.gray700)
                            .cornerRadius(20)
                    }
                    .padding(.bottom, 30)
                }
                .padding(.horizontal, 20)
                
            }
            
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(monthTitle())
                    .font(.headline)
                Spacer()
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                }
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            
            HStack {
                ForEach(weekdays, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.subtitle7)
                        .foregroundColor(.gray)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(daysInMonth(), id: \.self) { date in
                    Text(date == Date.distantPast ? "" :
                         "\(Calendar.current.component(.day, from: date))")
                        .frame(width: 36, height: 36) // 원형을 위해 가로세로 동일하게 설정
                        .background(
                            Circle()
                                .fill(backgroundColor(for: date))
                        )
                        .foregroundColor(foregroundColor(for: date))
                        .onTapGesture {
                            select(date)
                        }
                }
            }

            .frame(height: 300)
            
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    // 새로운 버튼 동작
                }) {
                    Image(.iconCalendarR)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
        
        }
        .padding()
    }
    
    // MARK: - Helpers
    
    private func monthTitle() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        return formatter.string(from: currentMonth)
    }
    
    private func changeMonth(by value: Int) {
        let calendar = Calendar.current
        
        // currentMonth에서 연도/월만 가져와서 1일로 고정
        var components = calendar.dateComponents([.year, .month], from: currentMonth)
        components.day = 1
        guard let firstOfMonth = calendar.date(from: components) else { return }
        
        // month 값 더하기
        if let newMonth = calendar.date(byAdding: .month, value: value, to: firstOfMonth) {
            currentMonth = newMonth
        }
    }
    
    private func daysInMonth() -> [Date] {
        let calendar = Calendar.current
        guard let monthRange = calendar.range(of: .day, in: .month, for: currentMonth),
              let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth)) else { return [] }
        
        var dates: [Date] = []
        let weekdayOffset = calendar.component(.weekday, from: firstOfMonth) - 1

        for _ in 0..<weekdayOffset {
            dates.append(Date.distantPast)
        }

        for day in monthRange {
            if let date = calendar.date(bySetting: .day, value: day, of: currentMonth) {
                dates.append(date)
            }
        }
        
        return dates
    }
    
    private func backgroundColor(for date: Date) -> Color {
        if date == Date.distantPast { return .clear } // 빈칸 처리

        let today = Calendar.current.startOfDay(for: Date())
        let target = Calendar.current.startOfDay(for: date)

        // 오늘 날짜인 경우 파란색
        if target == today {
            return .blue400
        }

        if let start = startDate, let end = endDate {
            return (date >= start && date <= end) ? .blue400 : .clear
        } else if let start = startDate {
            return date == start ? .blue400 : .clear
        }

        return .clear
    }

    private func foregroundColor(for date: Date) -> Color {
        if date == Date.distantPast { return .clear } // 빈칸 처리
        
        let target = Calendar.current.startOfDay(for: date)
        
        if let start = startDate, let end = endDate {
            return (target >= start && target <= end) ? .white : .black
        } else if let start = startDate {
            return target == start ? .white : .black
        }

        // 오늘 날짜도 선택 색상과 구분하려면 필요 시 조건 추가 가능
        let today = Calendar.current.startOfDay(for: Date())
        if target == today {
            return .white
        }
        
        return .black
    }

    
    private func select(_ date: Date) {
        if date == Date.distantPast { return } // 빈칸 클릭 무시
        
        if startDate == nil || (startDate != nil && endDate != nil) {
            startDate = date
            endDate = nil
        } else if let start = startDate {
            if date >= start {
                endDate = date
            } else {
                startDate = date
                endDate = nil
            }
        }
        
        if let start = startDate, let end = endDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
          //  dateClickAction("\(formatter.string(from: start)) ~ \(formatter.string(from: end))")
        }
    }
}
