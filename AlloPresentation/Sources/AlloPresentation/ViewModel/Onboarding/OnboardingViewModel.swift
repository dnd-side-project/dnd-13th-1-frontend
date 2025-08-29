//
//  OnboardingViewModel.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/29/25.
//

import Foundation

@Observable
@MainActor
public final class OnboardingViewModel: ViewModelable {
    struct State {
        var currentPage: Int = 0
    }
    enum Action {
        case didTapBackButton
        case didTapNextButton
    }
    var state: State
    var coordinator: Coordinator
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.state = State()
    }
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            if state.currentPage < 2 {
                state.currentPage += 1
            } else {
                coordinator.push(OnboardingScene.login)
            }
        }
    }
}
