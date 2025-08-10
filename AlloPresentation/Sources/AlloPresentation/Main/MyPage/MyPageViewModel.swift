//
//  MyPageViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import SwiftUI

public final class MyPageViewModel: ViewModelable {
    @Published var state = State()
    let coordinator: Coordinator
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    struct State {
    }
    enum Action {
        case backButtonDidTap
        case myPageDidTap
    }
    func action(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            coordinator.pop()
        case .myPageDidTap:
            coordinator.popToRoot()
        }
    }
}
