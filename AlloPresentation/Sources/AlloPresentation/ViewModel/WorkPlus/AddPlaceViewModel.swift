//
//  AddPlaceViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/18/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class AddPlaceViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var newPlaceName: String = ""
        var existingPlaces: [String] = []
    }

    var state: State
    let coordinator: Coordinator

    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapAddPlaceButton
    }

    // MARK: - Init
    public init(coordinator: Coordinator,existingPlaces: [String] = []) {
        self.coordinator = coordinator
        self.state = State(existingPlaces: existingPlaces)
    }

    // MARK: - Action Handler
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapAddPlaceButton:
            // 새로운 장소 추가 로직
            if !state.newPlaceName.isEmpty {
                state.existingPlaces.append(state.newPlaceName)
                state.newPlaceName = ""
            }
        }
    }
}

