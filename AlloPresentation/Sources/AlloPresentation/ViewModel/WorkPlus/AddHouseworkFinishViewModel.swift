//
//  AddHouseworkFinishViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/17/25.
//

import SwiftUI

@Observable
@MainActor
public final class AddHouseworkFinishViewModel: ViewModelable {
    // MARK: - State
    public struct State {
        public var tags: [String]
        public var myHouseworkTitle: String
        public var place: String
        public var routine: String
        public var deadline: String
        
        public init(myHouseworkTitle: String, place: String, routine: String, deadline: String, tags: [String]) {
            self.myHouseworkTitle = myHouseworkTitle
            self.place = place
            self.routine = routine
            self.deadline = deadline
            self.tags = tags
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
    
    // MARK: - Init
    public init(coordinator: Coordinator,
                myHouseworkTitle: String,
                place: String,
                routine: String,
                deadline: String,
                tags: [String]) {
        self.coordinator = coordinator
        self.state = State(
            myHouseworkTitle: myHouseworkTitle,
            place: place,
            routine: routine,
            deadline: deadline,
            tags: tags
        )
        print("✅ AddHouseworkFinishViewModel initialized with tags:", tags)
    }
    
    // MARK: - Action Handler
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapTagButton:
            coordinator.popToRoot()
        case .didTapNextButton:
            coordinator.push(AppScene.checklist)
        }
    }
}
