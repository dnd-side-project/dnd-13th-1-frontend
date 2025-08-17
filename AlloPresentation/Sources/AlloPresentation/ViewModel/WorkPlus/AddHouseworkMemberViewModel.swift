//
//  AddHouseworkMemberViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/17/25.
//

import SwiftUI

@Observable
@MainActor
public final class AddHouseworkMemberViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var tag: String
        var myHouseworkTitle: String
        var place: String
        var routine: String
        var deadline: String
        var tagList: [String] = []
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
    public init(coordinator: Coordinator, myHouseworkTitle: String, tagList: [String] = []) {
        self.state = State(tag: "", myHouseworkTitle: myHouseworkTitle, place: "", routine: "", deadline: "", tagList: tagList)
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapTagButton:
            coordinator.popToRoot()
        case .didTapNextButton:
            let data = HouseworkFinishData(
                myHouseworkTitle: state.myHouseworkTitle,
                place: state.place,
                routine: state.routine,
                deadline: state.deadline,
                tagList: state.tagList
            )
            coordinator.push(AppScene.houseworkPlusFinish(data: data))
        }
    }
}
