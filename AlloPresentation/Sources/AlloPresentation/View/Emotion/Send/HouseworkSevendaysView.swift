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
            ScrollView() {
                
            }
            Spacer()
            MainButton(
                title: "다음으로",
                action: { viewModel.action(.didTapNextButton)},
                style: .bottoomMain
            )
            .padding(.bottom, 46)
        }.padding(.horizontal, 20)
    }
}

struct HouseworEmotionkButton: View {
    let title: String
    let place: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack() {
                Text(place)
                    .font(.button1)
                    .foregroundStyle(.blue400)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
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
        .frame(height: 48)
    }
}
