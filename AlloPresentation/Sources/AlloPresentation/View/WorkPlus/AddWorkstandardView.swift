//
//  AddWorkstandardView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/15/25.
//

import SwiftUI
import AlloDomain

public struct AddWorkstandardView: View {
    @StateObject private var viewModel: AddWorkstandardViewModel
    public init(viewModel: AddWorkstandardViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    @State private var selectedStandards: Set<String> = []
    @State private var customTags: [String] = []
    @State private var isTipVisible: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    private let maxSelection = 5
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                TitleNavigationBar(title: "", onBack: { viewModel.action(.didTapBackButton) })
                VStack(alignment: .leading, spacing: 8) {
                    Text("대화로 집안일 기준을 정해볼까요?")
                        .font(.headline4)
                    Text("집안일 기준 태그는 최대 5개까지 추가할 수 있어요!")
                        .font(.body4)
                        .foregroundColor(.gray600)
                    HStack {
                        Image(.iconCheck)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(viewModel.state.housework.title)
                            .font(.subtitle6)
                            .foregroundColor(.gray500)
                    }
                }
                .padding(.bottom, 32)
                TagWriteTextFields(tags: $customTags, maxSelection: maxSelection)
                    .padding(.bottom, 20)
                    .focused($isTextFieldFocused)
                // 태그 영역 스크롤
                ScrollView(.vertical, showsIndicators: false) {
                    TagFlowView(
                        tags: viewModel.state.fetchedTags.map { $0.name } + customTags,
                        selectedTags: $selectedStandards
                    )
                    .padding(.top, 2)
                    .padding(.leading, 2)
                    .padding(.bottom, 120)
                }
            }
            .padding(.horizontal, 20)
            .contentShape(Rectangle())
            .onTapGesture {
                isTextFieldFocused = false
            }
            VStack {
                Spacer()
                MainButton(
                    title: selectedStandards.isEmpty ? "건너뛰기" : "다음으로",
                    action: {
                        // selectedStandards 안에서 구분
                        let allCases = Set(HouseworkStandard.allCases.map { $0.rawValue })
                        viewModel.state.selectedStandards = selectedStandards.filter { allCases.contains($0) }
                        viewModel.state.customTags = selectedStandards.filter { !allCases.contains($0) }
                        viewModel.action(.didTapNextButton)
                    },
                    style: selectedStandards.isEmpty ? .selectionNo : .bottoomMain
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 46)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            /// Tip 버튼 + TipView
            ZStack(alignment: .bottomTrailing) {
                if isTipVisible {
                    TipView()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .zIndex(1)
                        .offset(x: 13, y: -50)
                }
                
                Button {
                    withAnimation {
                        isTipVisible.toggle()
                    }
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
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing, 35)
            .padding(.bottom, 117)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
            .onAppear {
            Task {
                await viewModel.loadTags(groupId: 123) // 실제 groupId로 변경
                print("fetchedTags count:", viewModel.state.fetchedTags.count)
                        viewModel.state.fetchedTags.forEach { tag in
                            print("tagId:", tag.tagId, "name:", tag.name)
                        }
            }
        }
    }
}

struct TagFlowView: View {
    let tags: [String]
    let spacing: CGFloat = 12
    @Binding var selectedTags: Set<String>
    
    private var rows: [[String]] {
        stride(from: 0, to: tags.count, by: 2).map { start in
            let end = min(start + 2, tags.count)
            return Array(tags[start..<end])
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row, id: \.self) { tag in
                        StandardButton(
                            title: tag,
                            isSelected: Binding(
                                get: { selectedTags.contains(tag) },
                                set: { selected in
                                    if selected {
                                        selectedTags.insert(tag)
                                    } else {
                                        selectedTags.remove(tag)
                                    }
                                }
                            )
                        )
                    }
                    Spacer()
                }
            }
        }
    }
}

struct TagWriteTextFields: View {
    @Binding var tags: [String]
    let maxSelection: Int
    @FocusState private var isSearchFieldFocused: Bool
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                TextField(
                    tags.count >= maxSelection
                    ? "태그는 최대 \(maxSelection)개까지 추가할 수 있어요"
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
                        withAnimation {
                            tags.append(searchText)
                            searchText = ""
                        }
                    }
                } label: {
                    Image(.iconPlus)
                        .foregroundColor(tags.count < maxSelection ? .blue400 : .gray500)
                        .font(.title2)
                        .frame(width: 24, height: 24)
                }
                .disabled(tags.count >= maxSelection)
            }
            .padding(.leading, 16)
            .padding(.trailing, 12)
            .frame(height: 44)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(tags.count >= maxSelection ? Color.gray100 : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(
                        tags.count >= maxSelection
                        ? .gray200
                        : ((tags.count + (searchText.isEmpty ? 0 : 1)) > 0
                           ? .blue400
                           : .gray200),
                        lineWidth: 1
                    )
            )
        }
    }
}

struct TipView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
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
        .padding(.top, 5)
        .padding(.leading, 16)
        .frame(maxWidth: 276, maxHeight: 88, alignment: .topLeading)
        .background(
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue50)
                
                Triangle()
                    .fill(Color.blue50)
                    .frame(width: 20, height: 10)
                    .rotationEffect(.degrees(180))
                    .offset(x: 112, y: 5)
            }
        )
    }
}

// MARK: - Triangle Shape
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))   // 위 가운데
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // 오른쪽 아래
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // 왼쪽 아래
            path.closeSubpath()
        }
    }
}
