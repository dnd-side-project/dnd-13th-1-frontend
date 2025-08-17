//
//  AddWorkstandardView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/15/25.
//

import SwiftUI
import AlloDomain

public struct AddWorkstandardView: View {
    @State private var viewModel: AddWorkstandardViewModel
    public init(viewModel: AddWorkstandardViewModel, myHouseworkTitle: String) {
        let vm = AddWorkstandardViewModel(coordinator: viewModel.coordinator,
        myHouseworkTitle: myHouseworkTitle)
        self._viewModel = State(initialValue: vm)
    }
    @State private var selectedStandards: Set<String> = []
    @State private var customTags: [String] = []
    
    private let maxSelection = 5
    
    private let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    public var body: some View {
        VStack(alignment: .leading) {
            TitleNavigationBar(title: "")
            VStack(alignment: .leading) {
                Text("대화로 집안일 기준을 정해볼까요?")
                    .font(.headline4)
                Text("집안일 기준 태그는 최대 5개까지 추가할 수 있어요!")
                    .font(.body4)
                    .foregroundColor(.gray600)
                HStack {
                    Image(.iconCheck)
                        .resizable()
                        .frame(width: 24,height: 24)
                    Text(viewModel.state.myHouseworkTitle)
                        .font(.subtitle6)
                        .foregroundColor(.gray500)
                }
            }
            .padding(.bottom, 32)
            TagWriteTextFields(tags: $customTags, maxSelection: maxSelection)
                .padding(.bottom, 20)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
                
                ForEach(HouseworkStandard.allCases, id: \.self) { standard in
                    StandardButton(
                        standard: standard,
                        isSelected: Binding(
                            get: { selectedStandards.contains(standard.rawValue) },
                            set: { selected in
                                if selected {
                                    selectedStandards.insert(standard.rawValue)
                                } else {
                                    selectedStandards.remove(standard.rawValue)
                                }
                            }
                        )
                    )
                }
                // 사용자 커스텀 태그
                ForEach(customTags, id: \.self) { tag in
                    StandardButton(
                        title: tag,
                        isSelected: Binding(
                            get: { selectedStandards.contains(tag) },
                            set: { selected in
                                if selected {
                                    selectedStandards.insert(tag)
                                } else {
                                    selectedStandards.remove(tag)
                                }
                            }
                        )
                    )
                }
            }
            Spacer()
            HStack {
                Spacer()
                TipView()
            }
            .padding(.trailing, 20)
            .padding(.bottom,5)
            HStack {
                Spacer()
                Button {
                    // 버튼 액션
                } label: {
                    Image(.iconQuestion)
                        .frame(width: 24, height: 24)
                        .background(
                            Circle()
                                .stroke(.gray100, lineWidth: 1)
                                .frame(width: 50, height: 50)
                        )
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.trailing, 20)
            .padding(.bottom, 3)
            MainButton(
                title: selectedStandards.isEmpty && customTags.isEmpty ? "건너뛰기" : "다음으로",
                action: {
                    viewModel.state.selectedStandards = Array(selectedStandards)
                    viewModel.state.customTags = customTags
                    viewModel.action(.didTapNextButton)
                },
                style: selectedStandards.isEmpty && customTags.isEmpty ? .selectionNo : .bottoomMain)
            .padding(.bottom, 46)
        }
        .padding(.horizontal, 20)
    }
}

struct TagWriteTextFields: View {
    @Binding var tags: [String]   // 상위 뷰로 태그 전달
    let maxSelection: Int         // 최대 개수 전달
    @FocusState private var isSearchFieldFocused: Bool
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                TextField(
                    tags.count >= maxSelection
                    ? "태그는 최대 5개까지 추가할 수 있어요"
                    : "기준 태그 직접 작성하기 (최대 12자)",
                    text: $searchText
                )
                .textFieldStyle(PlainTextFieldStyle())
                .font(.subtitle7)
                .foregroundColor(isSearchFieldFocused ? .black : .gray300)
                .focused($isSearchFieldFocused)
                .disabled(tags.count >= maxSelection)
                
                Button {
                    if !searchText.isEmpty, searchText.count <= 12, tags.count < maxSelection {
                        tags.append(searchText)
                        searchText = ""
                    }
                } label: {
                    Image(.iconPlus)
                        .foregroundColor(tags.count < maxSelection ? .blue : .gray500)
                        .font(.title2)
                }
                .disabled(tags.count >= maxSelection) // 최대 개수 도달 시 버튼 비활성화
            }
            .frame(height: 44)
            .padding(.leading, 16)
            .padding(.trailing, 12)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.gray200, lineWidth: 1)
                    .background(tags.count >= maxSelection ? .gray100 : Color.clear)
            )
        }
    }
}

struct TipView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Tip")
                .font(.body2)
                .foregroundColor(.blue400)
            Text("이런식으로 작성하면 좋아요!")
                .font(.body5)
                .foregroundColor(.gray900)
            Text("ex) 방정리하기: 머리카락 줍기, 책상 위 정리 더 하기")
                .font(.body5)
                .foregroundColor(.gray900)
        }
        .frame(width: 276, height: 88)
        .padding(.vertical,8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue50)
        )
        
    }
}
