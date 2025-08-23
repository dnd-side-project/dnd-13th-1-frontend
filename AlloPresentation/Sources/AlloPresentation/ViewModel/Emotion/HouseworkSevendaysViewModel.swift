//
//  HouseworkSevendaysViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class HouseworkSevendaysViewModel: ViewModelable {
    // MARK: - State
    struct State {
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapNextButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    private let fetchDaysUscase: FetchHouseworkDaysUseCase
    public init(coordinator: Coordinator, fetchDaysUscase: FetchHouseworkDaysUseCase) {
        self.coordinator = coordinator
        self.state = State()
        self.fetchDaysUscase = fetchDaysUscase
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            coordinator.push(AppScene.emotionChoice)
        }
    }
}
