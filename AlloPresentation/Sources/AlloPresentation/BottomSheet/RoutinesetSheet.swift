//
//  RoutinesetSheet.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/13/25.
//

import SwiftUI

public struct RoutinesetSheet: View {
    let completeButtonAction: (String) -> Void
    private let categories = ["반복안함", "매일", "매주", "격주"]
    private let days = ["일", "월", "화", "수", "목", "금", "토"]
    @State private var selectedCategory: String? = nil
    @State private var selectedDays: Set<String> = []
    
    public init(completeButtonAction: @escaping (String) -> Void) {
        self.completeButtonAction = completeButtonAction
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
                .padding(.bottom, 16)
            
            ZStack {
                Text("루틴 설정")
                    .font(.subtitle1)
                    .foregroundColor(.gray900)
                    .padding(.bottom, 30)
                
                HStack {
                    Spacer()
                    Button(action: {
                        guard let category = selectedCategory else { return }

                        var routineString = category

                        if category == "매주" || category == "격주" {
                            if selectedDays.count == days.count { // 모든 요일 선택 시
                                routineString = "매일"
                            } else if !selectedDays.isEmpty {
                                let sortedDays = days.filter { selectedDays.contains($0) } // 순서 유지
                                routineString += " (" + sortedDays.joined(separator: ",") + ")"
                            }
                        }

                        completeButtonAction(routineString)
                    }) {
                        Text("완료")
                            .font(.button2)
                            .foregroundColor(.white)
                            .frame(width: 52, height: 32)
                            .background(.gray700)
                            .cornerRadius(20)
                    }

                }
                .padding(.horizontal, 20)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    VStack(alignment: .leading, spacing: 8) {
                        RoutineButton(
                            title: category,
                            isSelected: selectedCategory == category,
                            action: { selectedCategory = category }
                        )
                        
                        if (category == "매주" || category == "격주") && selectedCategory == category {
                            HStack(spacing: 10) {
                                ForEach(days, id: \.self) { day in
                                    Button {
                                        if selectedDays.contains(day) {
                                            selectedDays.remove(day)
                                        } else {
                                            selectedDays.insert(day)
                                        }
                                    } label: {
                                        Text(day)
                                            .font(.body3)
                                            .frame(width: 41, height: 41)
                                            .background(selectedDays.contains(day) ? .blue400 : .gray50)
                                            .foregroundColor(selectedDays.contains(day) ? .white : .gray400)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                            .padding(.leading, 30)
                        }
                    }
                }
            }
            .padding(.top, 24)
            Spacer()
        }
    }

}
