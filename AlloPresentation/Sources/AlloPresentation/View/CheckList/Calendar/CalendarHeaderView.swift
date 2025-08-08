//
//  CalendarHeaderView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/6/25.
//

import SwiftUI

struct CalendarHeaderView: View {
    
    let onTapDatePicker: () -> Void
    let onTapToday: () -> Void
    let onTapPreviousWeek: () -> Void
    let onTapNextWeek: () -> Void
    
    var body: some View {
        HStack(
            alignment: .center,
            spacing: 0
        ) {
            Button(
                action: {
                    // TODO: DatePicker 보여주기
                },
                label: {
                    Image(.iconDatepicker)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .padding(.trailing, 16)
                        .padding(.vertical, 8)
                }
            )
            Spacer(minLength: 0)
            Button(
                action: {
                    // TODO: 이전 주로 넘기기
                },
                label: {
                    Image(.iconChevronLeft)
                        .frame(maxWidth: 44, maxHeight: 44)
                }
            )
            Text("7월 넷째 주") // TODO: 월, 주 바인딩
                .font(.subtitle1)
                .foregroundStyle(.gray900)
                .padding(.horizontal, 16)
            Button(
                action: {
                    // TODO: 다음 주로 넘기기
                },
                label: {
                    Image(.iconChevronRight)
                        .frame(maxWidth: 44, maxHeight: 44)
                }
            )
            Spacer(minLength: 0)
            Button(
                action: {
                    // TODO: 오늘 이동
                },
                label: {
                    Text("오늘")
                        .font(.button1)
                        .foregroundStyle(.gray500)
                        .frame(width: 50, height: 32)
                        .cornerRadius(.radius3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.gray300, lineWidth: 1)
                                .padding(1)
                        )
                        .padding(.vertical, 6)
                }
            )
        }
        .frame(width: .infinity, height: 44)
        .padding(.horizontal, 20)
    }
}
