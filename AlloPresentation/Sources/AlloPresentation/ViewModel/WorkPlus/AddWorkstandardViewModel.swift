//
//  AddWorkstandardViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/17/25.
//

import SwiftUI

public final class AddWorkstandardViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var myHouseworkTitle: String
        var selectedStandards: [String] = []
        var customTags: [String] = []
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapTagButton
        //case didTapPlusButton
        case didTapNextButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    public init(coordinator: Coordinator, myHouseworkTitle: String) {
        self.state = State(myHouseworkTitle: myHouseworkTitle)
        self.coordinator = coordinator
    }

    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapTagButton:
            coordinator.popToRoot()
        case .didTapNextButton:
            let allTags = state.selectedStandards + state.customTags
            print("✅ AddHouseworkFinishViewModel initialized with tags:", allTags)

            coordinator.push(AppScene.houseworkMember(
                myHouseworkTitle: state.myHouseworkTitle,
                tagList: allTags
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
