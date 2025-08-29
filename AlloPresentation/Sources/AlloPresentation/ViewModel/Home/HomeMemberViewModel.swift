//
//  HomeMemberViewModel.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/30/25.
//

import Foundation
import AlloDomain

@Observable
public final class HomeMemberViewModel: ViewModelable {
    struct State {
        var members: [Member] = []
    }
    enum Action {
        case load
        case backButtonTapped
        case memberAddButtonTapped
    }
    private let fetchMemberUseCase: FetchMemberUseCase
    var coordinator: Coordinator
    var state: State
    public init(coordinator: Coordinator, fetchMemberUseCase: FetchMemberUseCase) {
        self.coordinator = coordinator
        self.fetchMemberUseCase = fetchMemberUseCase
        self.state = .init()
    }
    func action(_ action: Action) {
        switch action {
        case .load:
            Task {
                do {
                    let members = try await fetchMemberUseCase.execute()
                    state.members = members
                } catch(let error) {
                    dump(error)
                }
            }
        case .memberAddButtonTapped:
            coordinator.push(AppScene.homeInvite)
        case .backButtonTapped:
            coordinator.pop()
        }
    }
}
