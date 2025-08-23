//
//  EmotionSendMemberViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/21/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class EmotionSendMemberViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var members: [Member] = []
        var selectedMembers: [Member] = []
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
    public init(coordinator: Coordinator, fetchMemberUscase: FetchMemberUseCase) {
        self.coordinator = coordinator
        self.state = State()
        self.fetchMemberUseCase = fetchMemberUscase
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            coordinator.push(AppScene.houseworkSevendays)
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

extension EmotionSendMemberViewModel {
    func toggleMember(_ member: Member) {
        if state.selectedMembers.contains(member) {
            state.selectedMembers.removeAll { $0 == member }
        } else {
            state.selectedMembers.append(member)
        }
    }
}
