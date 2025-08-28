//
//  OnboardingCompleteViewModel.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/29/25.
//

import Foundation
import AlloDomain

@Observable
@MainActor
public final class OnboardingCompleteViewModel: ViewModelable {
    struct State {
        var nickname: String
    }
    enum Action {
        case didTapBackButton
        case didTapEnterGroupButton
        case didTapCreateGroupButton
    }
    var state: State
    var coordinator: Coordinator
    public init(coordinator: Coordinator, nickname: String) {
        self.coordinator = coordinator
        self.state = State(nickname: nickname)
    }
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapEnterGroupButton:
            coordinator.push(OnboardingScene.enterGroup)
        case .didTapCreateGroupButton:
            coordinator.push(OnboardingScene.createGroup)
        }
    }
}
