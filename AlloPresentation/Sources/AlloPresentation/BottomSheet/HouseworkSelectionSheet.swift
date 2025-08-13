//
//  HouseworkSelectionSheet.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/12/25.
//

import SwiftUI
import AlloDomain

struct HouseworkSelectionSheet: View {
    let worklistClickAction: () -> Void
    
    public init(worklistClickAction: @escaping () -> Void) {
        self.worklistClickAction = worklistClickAction
    }
    
    @FocusState private var isSearchFieldFocused: Bool
    @State private var searchText: String = ""
    @State private var selectedCategory: String = "방"
    private let categories = ["방", "욕실", "주방", "세탁", "기타"]
    var filteredCategories: [HouseworkCategory] {
        if searchText.isEmpty {
            return HouseworkCategory.allCases
        }
        return HouseworkCategory.allCases.filter { category in
            category.tasks.contains { task in
                task.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
            Text("집안일 선택")
                .font(.subtitle1)
                .foregroundColor(.GRAY_900)
            // 검색창
            HStack {
                Image(.icWorkSearch)
                TextField("집안일을 검색해보세요!", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.subtitle7)
                    .foregroundColor(isSearchFieldFocused ? .black : .GRAY_300)
                    .focused($isSearchFieldFocused)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(isSearchFieldFocused ? .BLUE_400 : Color.GRAY_200, lineWidth: 1)
            )
            .padding(.horizontal, 20)
            HStack(spacing: 4) {
                ForEach(categories, id: \.self) { category in
                    Button {
                        selectedCategory = category
                    } label: {
                        Text(category)
                            .frame(height: 32)
                            .padding(.horizontal, 12)
                            .background(
                                Capsule()
                                    .fill(searchText.isEmpty
                                          ? (selectedCategory == category ? .BLUE_400 : Color.white)
                                          : Color.white)
                                    .stroke(Color.GRAY_200, lineWidth: 1)
                            )
                            .foregroundColor(searchText.isEmpty
                                             ? (selectedCategory == category ? .white : .GRAY_600)
                                             : .GRAY_600)
                            .font(.button2)
                    }
                    .disabled(!searchText.isEmpty)
                }
            }
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        ScrollViewReader { proxy in
            ScrollView {
                if filteredCategories.isEmpty || filteredCategories.allSatisfy({ category in
                    category.tasks.filter { task in
                        searchText.isEmpty || task.localizedCaseInsensitiveContains(searchText)
                    }.isEmpty
                }) {
                    // 검색 결과 없음 뷰
                    VStack(spacing: 16) {
                        Image(.icHomeUnselected)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 113, height: 113)
                        Text("검색되는 프리셋이 없어요!\n다른 검색어로 시도해주세요")
                            .font(.subtitle7)
                            .foregroundColor(.GRAY_400)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 60)
                }
                // 검색 결과 있으면 리스트 보여주기
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(filteredCategories, id: \.self) { category in
                        let filteredTasks = category.tasks.filter { task in
                            searchText.isEmpty || task.localizedCaseInsensitiveContains(searchText)
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text(category.rawValue)
                                .font(.body3)
                                .foregroundColor(.GRAY_700)
                                .padding(.horizontal, 20)
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(filteredTasks, id: \.self) { task in
                                    Text(task)
                                        .font(.subtitle2)
                                        .foregroundColor(.GRAY_900)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 20)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.white)
                                }
                            }
                        }
                        .id(category.rawValue)
                    }
                }
            }
            .onChange(of: selectedCategory) { _, newValue in
                withAnimation {
                    proxy.scrollTo(newValue, anchor: .top)
                }
            }
        }
    }
}
