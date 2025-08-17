//
//  AddWorkstandardViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/17/25.
//

import SwiftUI
import AlloDomain

public final class AddWorkstandardViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var housework: Housework
        var selectedStandards: [String] = []
        var customTags: [String] = []
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapTagButton
        case didTapNextButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    public init(coordinator: Coordinator, housework: Housework) {
        self.coordinator = coordinator
        self.state = State(housework: housework)
    }

    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapTagButton:
            coordinator.popToRoot()
        case .didTapNextButton:
            let allTags = state.selectedStandards + state.customTags
            let updatedHousework = Housework(
                id: state.housework.id,
                place: state.housework.place,
                title: state.housework.title,
                member: [],
                date: state.housework.date,
                isDone: state.housework.isDone,
                routine: state.housework.routine,
                tags: allTags
            )
            coordinator.push(AppScene.houseworkMember(
                housework: updatedHousework
            ))
        }
    }
}

extension AddWorkstandardViewModel {
    private func addHouseWorkAction(_ action: Action) {
//        switch action {
//            
//        }
    }
}
