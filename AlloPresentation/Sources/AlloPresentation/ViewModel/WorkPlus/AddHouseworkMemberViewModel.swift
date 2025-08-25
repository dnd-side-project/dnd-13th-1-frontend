//
//  AddHouseworkMemberViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/17/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class AddHouseworkMemberViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var housework: Housework
        var members: [Member] = []
        var selectedMembers: [Member] = []
        var tagList: [String] = []
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapNextButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    private let fetchMemberUseCase: FetchMemberUseCase
    public init(coordinator: Coordinator, housework: Housework, fetchMemberUscase: FetchMemberUseCase) {
        self.coordinator = coordinator
        self.state = State(housework: housework)
        self.fetchMemberUseCase = fetchMemberUscase
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            let updatedHousework = Housework(
                id: state.housework.id,
                place: state.housework.place,
                title: state.housework.title,
                member: state.selectedMembers,
                date: state.housework.date,
                isDone: state.housework.isDone,
                routine: state.housework.routine,
                tags: state.housework.tags
            )
            //TODO: -- 알람 처리
            coordinator.push(AppScene.houseworkPlusFinish(housework: updatedHousework))
        }
    }
    
    func fetchMembers() async {
        do {
            let members = try await fetchMemberUseCase.execute()
            state.members = members
        } catch {
            print("멤버 로드 실패: \(error)")
        }
    }

}

extension AddHouseworkMemberViewModel {
    func toggleMember(_ member: Member) {
        if state.selectedMembers.contains(member) {
            state.selectedMembers.removeAll { $0 == member }
        } else {
            state.selectedMembers.append(member)
        }
    }
}
