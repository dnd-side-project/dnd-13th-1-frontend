//
//  SelectGroupTypeViewModel.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import Foundation
import AlloDomain

@Observable
@MainActor
public final class SelectGroupTypeViewModel: ViewModelable {
    struct State {
        var selectedGroupType: GroupType?
    }
    enum Action {
        case didTapBackButton
        case didSelectGroupType(GroupType)
        case didTapNextButton
    }
    var state: State
    var coordinator: Coordinator
    let createGroupUseCase: CreateGroupUseCase
    public init(coordinator: Coordinator, createGroupUseCase: CreateGroupUseCase) {
        self.state = .init()
        self.coordinator = coordinator
        self.createGroupUseCase = createGroupUseCase
    }
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case let .didSelectGroupType(type):
            if state.selectedGroupType == type {
                self.state.selectedGroupType = nil
            } else {
                self.state.selectedGroupType = type
            }
        case .didTapNextButton:
            if let type = state.selectedGroupType {
                Task {
                    do {
                        let backGroundTypeNum = switch type {
                        case .roommate:
                            0
                        case .family:
                            1
                        case .lover:
                            2
                        }
                        let groupInfo = try await self.createGroupUseCase.execute(
                            backGroundTypeNum: backGroundTypeNum
                        )
                        if let code = groupInfo.inviteCode {
                            coordinator.push(
                                OnboardingScene.copyInviteCode(
                                    inviteCode: code,
                                    groupId: groupInfo.groupId
                                )
                            )
                        }
                    } catch {
                        dump(error)
                    }
                }
            }
        }
    }
}
