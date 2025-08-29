//
//  EmotionViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import SwiftUI
import AlloDomain
@Observable
@MainActor
public final class EmotionViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var emotions: [EmotionList] = []
        var selectedFilter: String = "received"
        var sortOrder: String = "desc"
        var name: String? = ""
    }
    // MARK: - Action
    enum Action {
        case backButtonDidTap
        case didTapSendButton
        case didTapEmotionCard(id: Int)
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    // MARK: - Dependencies
    private let fetchMemberUseCase: FetchMemberUseCase
    private let getEmotionListUscase: FetchEmotionUseCase
    private let emotionDetailUseCase: EmotionDetailUseCase
    public init(coordinator: Coordinator, fetchMemberUseCase: FetchMemberUseCase, getEmotionListUscase: FetchEmotionUseCase, emotionDetailUseCase: EmotionDetailUseCase) {
        self.coordinator = coordinator
        self.state = State()
        self.fetchMemberUseCase = fetchMemberUseCase
        self.getEmotionListUscase = getEmotionListUscase
        self.emotionDetailUseCase = emotionDetailUseCase
    }
    
    func action(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            coordinator.pop()
        case .didTapSendButton:
            let housework = Housework(id: 0, place: "", title: "", member: [], date: Date(), isDone: false, routine: .none, tags: [])
            coordinator.push(AppScene.emotionMember(housework: housework))
        case .didTapEmotionCard(let id):
           didSelectEmotion(id: id)
        }
    }
    
    func didSelectEmotion(id: Int) {
        Task {
            do {
                let detail = try await emotionDetailUseCase.execute(id: id)
                coordinator.push(AppScene.emotionDetails(detailEmotion: detail, isReceived: state.selectedFilter == "received"))
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
extension EmotionViewModel {
    public func load() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.loadProfile() }
            group.addTask { await self.loadEmotionList()}
        }
    }
    
    func loadEmotionList() async {
        do {
            let result = try await getEmotionListUscase.execute(
                filter: state.selectedFilter,
                sorted: state.sortOrder
            )
            print("loadEmotionList - fetched count: \(result.count)")
            self.state.emotions = result
        } catch {
            print("failed to fetch houseworks")
        }
    }
    
    func loadProfile() async {
        do {
            let members = try await fetchMemberUseCase.execute()
            if let me = members.first {
                state.name = me.name
            }
        } catch {
            // Silent fail for draft
        }
    }
    
    func sortEmotions(by sortType: SortType) {
        switch sortType {
        case .latest:
            state.emotions.sort { $0.createdTime > $1.createdTime }
        case .oldest:
            state.emotions.sort { $0.createdTime < $1.createdTime }
        }
    }
}
