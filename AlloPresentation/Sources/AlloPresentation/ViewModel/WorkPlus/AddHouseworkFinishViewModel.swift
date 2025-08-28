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
        case .didTapNextButton:
            let useCase = addHouseworkUseCase
            let housework = state.housework
            Task {
                do {
                    try await useCase.execute(housework: housework)
                    await MainActor.run {
                        coordinator.popToRoot()
                    }
                } catch {
                    print("집안일 추가 실패: \(error)")
                }
            }
        }
    }
}
