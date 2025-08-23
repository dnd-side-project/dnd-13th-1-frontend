//
//  EmotionView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import SwiftUI

public struct EmotionView: View {
    @State private var viewModel: EmotionViewModel
    @State private var selectedTab: TabType = .received
    @State private var sortType: SortType = .latest
    
    public init(viewModel: EmotionViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                if selectedTab == .received {
                    Text("주현님,")
                        .font(.headline4)
                        .foregroundColor(.gray900)

                    (
                        Text("0")
                            .font(.headline4)
                            .foregroundColor(.blue400)
                        +
                        Text("개의 마음이 도착해있어요!")
                            .font(.headline4)
                            .foregroundColor(.gray900)
                    )
                    .font(.headline4)

                } else if selectedTab == .sent {
                    (
                        Text("주현님이 \n")
                            .font(.headline4)
                            .foregroundColor(.gray900)
                        +
                        Text("지금까지 보낸 마음 ")
                            .font(.headline4)
                            .foregroundColor(.gray900)
                        +
                        Text("0 ")
                            .font(.headline4)
                            .foregroundColor(.blue400)
                        +
                        Text("개")
                            .font(.headline4)
                            .foregroundColor(.gray900)
                    )
                    .font(.headline4)
                }
            }
            .frame(height: 100)
            .padding(.top, 32)

            // Header
            EmotionHeaderView(
                selectedTab: $selectedTab,
                sortType: $sortType
            )
            .padding(.top, 10)
            
            // 리스트 (스크롤뷰)
            ScrollView {
                VStack(spacing: 12) {
//                    ForEach(viewModel.items) { item in
//                        EmotionCell(item: item)
//                    }
                }
                .padding(.vertical, 8)
            }
        }.padding(.leading, 20)
        .overlay(alignment: .bottomTrailing) {
                EmotionFloatingButton(viewModel: viewModel)
                .padding(.trailing, 20)
                .padding(.bottom, 20)
        }
    }
}

// MARK: - Header
struct EmotionHeaderView: View {
    @Binding var selectedTab: TabType
    @Binding var sortType: SortType
    
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Button {
                    selectedTab = .received
                } label: {
                    Text("받은 마음")
                        .font(.button2)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .foregroundColor(selectedTab == .received ? .white : .gray600)
                        .background(selectedTab == .received ? .blue400 : Color.white)
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(selectedTab == .received ? .blue400 : .gray200, lineWidth: 1)
                        )
                }
                .frame(height: 32)
                
                Button {
                    selectedTab = .sent
                } label: {
                    Text("보낸 마음")
                        .font(.button2)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .foregroundColor(selectedTab == .sent ? .white : .gray600)
                        .background(selectedTab == .sent ? .blue400 : Color.white)
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(selectedTab == .sent ? .blue400 : .gray200, lineWidth: 1)
                        )
                }
                .frame(height: 32)
            }
            
            Spacer()
            // 정렬 버튼
            Button {
                // 버튼 누를 때 토글
                sortType = (sortType == .latest) ? .oldest : .latest
            } label: {
                HStack(spacing: 4) {
                    Image(.iconSort)
                    Text(sortType == .latest ? "최신순" : "오래된 순")
                        .foregroundColor(.gray600)
                        .font(.button3)
                }
            }
            .padding(.vertical, 8)
            .padding(.trailing, 25)
        }
    }
}

// MARK: - Cell (예시)
struct EmotionCell: View {
    let item: EmotionItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.title)
                .font(.headline)
            Text("From. \(item.sender)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
}
struct EmotionFloatingButton: View {
    @ObservedObject var viewModel: EmotionViewModel
    
    var body: some View {
        Button(
            action: {
                viewModel.action(.didTapSendButton)
            }, label: {
                Image(.iconMessage)
                    .frame(width: 50, height: 50)
            }
        )
    }
}

// MARK: - Model
enum TabType {
    case received, sent
}
enum SortType {
    case latest, oldest
}
struct EmotionItem: Identifiable {
    let id = UUID()
    let title: String
    let sender: String
}
