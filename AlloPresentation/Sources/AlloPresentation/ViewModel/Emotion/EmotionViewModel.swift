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
    private let getEmotionListUscase: FetchEmotionUseCase
    private let emotionDetailUseCase: EmotionDetailUseCase
    public init(coordinator: Coordinator, getEmotionListUscase: FetchEmotionUseCase, emotionDetailUseCase: EmotionDetailUseCase) {
        self.coordinator = coordinator
        self.state = State()
        self.getEmotionListUscase = getEmotionListUscase
        self.emotionDetailUseCase = emotionDetailUseCase
    }
    
    func action(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            coordinator.pop()
        case .didTapSendButton:
            coordinator.push(AppScene.emotionMember)
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
    public func loadEmotionList() async {
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
}
extension EmotionViewModel {
    func sortEmotions(by sortType: SortType) {
        switch sortType {
        case .latest:
            state.emotions.sort { $0.createdTime > $1.createdTime }
        case .oldest:
            state.emotions.sort { $0.createdTime < $1.createdTime }
        }
    }
}
