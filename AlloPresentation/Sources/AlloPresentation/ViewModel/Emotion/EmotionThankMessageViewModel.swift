//
//  EmotionThankMessageViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI
import AlloDomain
@Observable
@MainActor
public final class EmotionThankMessageViewModel: ViewModelable {
    // MARK: - State
    struct State {
    }
    // MARK: - Action
    enum Action {
        case backButtonDidTap
        case didTapSendButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.state = State()
    }
    
    func action(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            coordinator.pop()
        case .didTapSendButton:
            coordinator.pop()
        }
    }
}

