//
//  AddHouseworkFinishViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/17/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class AddHouseworkFinishViewModel: ViewModelable {
    // MARK: - State
    public struct State {
        public var housework: Housework
        public init(housework: Housework) {
            self.housework = housework
        }
    }
    
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapTagButton
        case didTapNextButton
    }
    
    // MARK: - Properties
    public var state: State
    let coordinator: Coordinator
    private let addHouseworkUseCase: AddHouseworkUseCase
    // MARK: - Init
    public init(coordinator: Coordinator,
                addHouseworkUseCase: AddHouseworkUseCase,
                housework: Housework) {
        self.coordinator = coordinator
        self.addHouseworkUseCase = addHouseworkUseCase
        self.state = State(housework: housework)
    }
    
    // MARK: - Action Handler
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapTagButton:
            coordinator.popToRoot()
        case .didTapNextButton:
            let useCase = addHouseworkUseCase
            let housework = state.housework
            let groupId = 0
            Task {
                try await useCase.execute(groupId: groupId,housework: housework)
                await MainActor.run {
                    coordinator.popToRoot()
                }
            }

        }
    }
}
