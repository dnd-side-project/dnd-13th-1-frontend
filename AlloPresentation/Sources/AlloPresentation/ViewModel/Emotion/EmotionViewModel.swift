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
        var selectedFilter: String = "from"
        var sortOrder: String = "desc"
    }
    // MARK: - Action
    enum Action {
        case backButtonDidTap
        case didTapSendButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    private let getEmotionListUscase: FetchEmotionUseCase
    public init(coordinator: Coordinator, getEmotionListUscase: FetchEmotionUseCase) {
        self.coordinator = coordinator
        self.state = State()
        self.getEmotionListUscase = getEmotionListUscase
    }
    
    func action(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            coordinator.pop()
        case .didTapSendButton:
            coordinator.push(AppScene.emotionMember)
        }
    }
    
    public func loadEmotionList() async {
        do {
            let result = try await getEmotionListUscase.execute(
                filter: state.selectedFilter,
                sorted: state.sortOrder
            )
            self.state.emotions = result
        } catch {
            print("failed to fetch houseworks")
        }
    }

}
