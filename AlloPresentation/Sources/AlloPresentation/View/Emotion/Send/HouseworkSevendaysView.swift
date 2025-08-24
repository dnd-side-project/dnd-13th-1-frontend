//
//  HouseworkSevendaysView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI
import AlloDomain

public struct HouseworkSevendaysView: View {
    @StateObject private var viewModel: HouseworkSevendaysViewModel
    @State private var selectedHouseworks: Set<Int> = []
    
    public init(viewModel: HouseworkSevendaysViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            TitleNavigationBar(title: "", onBack: { viewModel.action(.didTapBackButton)})
            Text("마음을 전할 집안일을 선택해주세요.")
                .font(.headline4)
                .foregroundStyle(.gray900)
            Text("최근 7일 내 완료된 집안일만 마음을 보낼 수 있어요!")
                .font(.body4)
                .foregroundStyle(.gray600)
            HStack(spacing: 8) {
                Image(.iconCheck)
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(viewModel.state.receiverName)
                    .font(.subtitle6)
                    .foregroundColor(.gray500)
            }
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.state.sevenDaysHouseworks, id: \.date) { day in
                        HouseworkDaySection(day: day, viewModel: viewModel)
                    }
                }
                .padding(.top, 10)
            }
            .padding(.top, 32)
            Spacer()
            MainButton(
                title: "다음으로",
                action: { viewModel.action(.didTapNextButton)},
                style: .bottoomMain
            )
            .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .task {
            await viewModel.loadSevenDaysHouseworks()
        }
    }
}

// MARK: - Day Section View
struct HouseworkDaySection: View {
    let day: HouseworkSevendays
    @ObservedObject var viewModel: HouseworkSevendaysViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(day.date.formattedKoreanDate())
                .font(.body3)
                .foregroundStyle(.gray600)
            
            ForEach(day.houseWorks) { housework in
                HouseworkRow(housework: housework, viewModel: viewModel)
                    .padding(.vertical, 10)
            }
        }
    }
}

struct HouseworkRow: View {
    let housework: HouseworkRecent
    @ObservedObject var viewModel: HouseworkSevendaysViewModel
    
    var body: some View {
        HouseworEmotionkButton(
            title: housework.title,
            place: housework.place,
            isSelected: viewModel.state.selectedHouseworks.contains(housework.id),
            action: {
                viewModel.toggleHousework(housework)
            }
        )
    }
}
// MARK: - Emotion Button View
struct HouseworEmotionkButton: View {
    let title: String
    let place: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(place)
                    .font(.button1)
                    .foregroundStyle(.blue400)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(isSelected ? .white : .blue50)
                    )
                    .padding(.leading, 10)
                
                Text(title)
                    .font(.subtitle4)
                    .foregroundStyle(isSelected ? .blue400 : .gray900)
                    .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
                    .padding(.leading, 10)
            }
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? .blue50 : .gray25)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? .blue400 : .gray25, lineWidth: 2)
        )
        .padding(.horizontal, 2)
        .frame(height: 48)
    }
}

extension String {
    func formattedKoreanDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "ko_KR")
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "M월 d일 EEEE"
        outputFormatter.locale = Locale(identifier: "ko_KR")
        
        if let date = inputFormatter.date(from: self) {
            return outputFormatter.string(from: date)
        }
        return self
    }
}
