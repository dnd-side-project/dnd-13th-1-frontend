//
//  EmotionView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import SwiftUI

public struct EmotionView: View {
    @StateObject private var viewModel: EmotionViewModel
    @State private var selectedTab: TabType = .received
    @State private var sortType: SortType = .latest
    
    public init(viewModel: EmotionViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            headerSection
            EmotionHeaderView(
                selectedTab: $selectedTab,
                sortType: $sortType
            )
            .padding(.top, 10)
            .onChange(of: selectedTab) { _, newTab in
                viewModel.state.selectedFilter = (newTab == .received) ? "received" : "sent"
                Task { await viewModel.loadEmotionList() }
            }
            .onChange(of: sortType) { _, newSort in
                viewModel.sortEmotions(by: newSort)
            }
            // 리스트 (스크롤뷰)
            ScrollView(showsIndicators: false) {
                if viewModel.state.emotions.isEmpty {
                    VStack(spacing: 16) {
                        Image(.illustrationEmpty)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 235, height: 220)
                        if selectedTab == .received {
                            Text("받은 마음이 없어요!")
                                .font(.subtitle7)
                                .foregroundColor(.gray400)
                                .multilineTextAlignment(.center)
                        } else {
                            Text("보낸 마음이 없어요!")
                                .font(.subtitle7)
                                .foregroundColor(.gray400)
                                .multilineTextAlignment(.center)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 60)
                } else {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.state.emotions) { emotion in
                            EmotionCell(emotion: emotion) {
                                viewModel.action(.didTapEmotionCard(id: emotion.id))
                            }
                        }
                    }
                }
            }
            .padding(.top, 10)
        }
        .padding(.horizontal, 20)
        .task { await viewModel.load() }
        .overlay(alignment: .bottomTrailing) {
            EmotionFloatingButton(viewModel: viewModel)
                .padding(.trailing, 20)
                .padding(.bottom, 20)
        }
    }
}
extension EmotionView {
    private var headerSection: some View {
        VStack(alignment: .leading) {
            if selectedTab == .received {
                Text("\(viewModel.state.name ?? ""),")
                    .font(.headline4)
                    .foregroundColor(.gray900)
                
                (
                    Text("\(viewModel.state.emotions.count)")
                        .foregroundColor(.blue400)
                    +
                    Text("개의 마음이 도착해있어요!")
                        .foregroundColor(.gray900)
                )
                .font(.headline4)
                .fixedSize(horizontal: false, vertical: true) // 높이 고정
                
            } else if selectedTab == .sent {
                (
                    Text("\(viewModel.state.name ?? "")이\n")
                        .foregroundColor(.gray900)
                    +
                    Text("지금까지 보낸 마음 ")
                        .foregroundColor(.gray900)
                    +
                    Text("\(viewModel.state.emotions.count) ")
                        .foregroundColor(.blue400)
                    +
                    Text("개")
                        .foregroundColor(.gray900)
                )
                .font(.headline4)
                .fixedSize(horizontal: false, vertical: true) // 높이 고정
            }
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 32)
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
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
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
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
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
            Button {
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
            .padding(.trailing, 20)
        }
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
