//
//  CalendarDayView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/6/25.
//

import SwiftUI

struct CalendarDayView: View {
    
    let dayOfTheWeek: String
    let day: Int
    let isSelected: Bool
    let hasTask: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            VStack(alignment: .center, spacing: 0) {
                Text(dayOfTheWeek)
                    .font(.body6)
                    .foregroundStyle(isSelected ? .white : .gray300)
                Text("\(day)")
                    .font(.body3)
                    .foregroundStyle(isSelected ? .white : .gray900)
            }
            .frame(width: 40, height: 52)
            .background(isSelected ? .blue400 : .white)
            .cornerRadius(.radius1)
            Circle()
                .foregroundStyle(hasTask ? .blue200 : .white)
                .frame(width: 6, height: 6)
        }
        .frame(width: 40, height: 64)
    }
}
