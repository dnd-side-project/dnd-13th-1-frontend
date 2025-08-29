//  RoutinesetSheet.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/13/25.
//

import SwiftUI
import AlloDomain

public struct RoutinesetSheet: View {
    let completeButtonAction: (String, [String], String) -> Void
    private let categories = ["반복안함", "매일", "매주", "격주"]
    private let days = ["일", "월", "화", "수", "목", "금", "토"]
    
    @State private var selectedCategory: String?
    @State private var selectedDays: Set<String> = []
    
    var initialRoutine: String = ""

    public init(initialRoutine: String, completeButtonAction: @escaping (String, [String], String) -> Void) {
        self.initialRoutine = initialRoutine
        self.completeButtonAction = completeButtonAction
        _selectedCategory = State(initialValue: initialRoutine)
    }

    public var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(.gray200)
                .frame(width: 40, height: 4)
                .padding(.top, 13)
            
            ZStack {
                Text("루틴 설정")
                    .font(.subtitle1)
                    .foregroundColor(.gray900)
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                
                HStack {
                    Spacer()
                    Button(action: completeButtonTapped) {
                        Text("완료")
                            .font(.button2)
                            .foregroundColor(.white)
                            .frame(width: 52, height: 32)
                            .background(isCompleteButtonEnabled ? .gray700 : .gray300)
                            .cornerRadius(20)
                            .padding(.top, 20)
                            .padding(.bottom, 30)
                    }
                    .disabled(!isCompleteButtonEnabled)
                }
                .padding(.horizontal, 20)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    VStack(alignment: .leading, spacing: 8) {
                        RoutineButton(
                            title: category,
                            isSelected: selectedCategory == category,
                            action: {
                                selectedCategory = category
                                if category != "매주" && category != "격주" {
                                    selectedDays.removeAll()
                                }
                            }
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
    
    // MARK: - Computed Properties
    private var isCompleteButtonEnabled: Bool {
        guard let category = selectedCategory else { return false }
        if category == "매주" || category == "격주" {
            return !selectedDays.isEmpty
        } else {
            return true
        }
    }
    
    // MARK: - Actions
    private func completeButtonTapped() {
        guard let category = selectedCategory else { return }
        let selectedDaysArray = days.filter { selectedDays.contains($0) }
        
        // 모든 요일 선택 시 자동으로 "매일"로 변경
        let finalCategory: String
        if (category == "매주" || category == "격주") && selectedDaysArray.count == days.count {
            finalCategory = "매일"
        } else {
            finalCategory = category
        }
        
        let routineText: String
        if (finalCategory == "매주" || finalCategory == "격주") && !selectedDaysArray.isEmpty {
            routineText = "\(finalCategory) (\(selectedDaysArray.joined(separator: ",")))"
        } else {
            routineText = finalCategory
        }
        
        completeButtonAction(finalCategory, selectedDaysArray, routineText)
    }
}
