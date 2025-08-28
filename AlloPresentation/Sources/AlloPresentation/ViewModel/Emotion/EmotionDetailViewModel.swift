//
//  EmotionDetailViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/26/25.
//

import SwiftUI
import AlloDomain
@Observable
@MainActor
public final class EmotionDetailViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var emotionDetail: EmotionDetail
        var isReceived: Bool
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapSendButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    //usecase
    private let emotionDetailUseCase: EmotionDetailUseCase
    public init(coordinator: Coordinator, emotionDetailUseCase: EmotionDetailUseCase, emotionDetail: EmotionDetail, isReceived: Bool) {
        self.coordinator = coordinator
        self.emotionDetailUseCase = emotionDetailUseCase
        self.state = State(emotionDetail: emotionDetail, isReceived: isReceived)
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapSendButton:
            coordinator.popToRoot()
        }
    }
}
