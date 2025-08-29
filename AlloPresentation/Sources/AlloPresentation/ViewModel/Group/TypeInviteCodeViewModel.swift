//
//  TypeInviteCodeViewModel.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import Foundation
import AlloDomain

@Observable
@MainActor
public final class TypeInviteCodeViewModel: ViewModelable {
    struct State {
        var inputText: String = ""
    }
    enum Action {
        case didTapBackButton
        case didTapNextButton
    }
    var state: State
    var coordinator: Coordinator
    let enterGroupUseCase: EnterGroupUseCase
    let setMyGroupUseCase: SetMyGroupUseCase
    let getMyGroupUseCase: GetMyGroupUseCase
    public init(coordinator: Coordinator, enterGroupUseCase: EnterGroupUseCase, setMyGroupUseCase: SetMyGroupUseCase, getMyGroupUseCase: GetMyGroupUseCase) {
        self.state = .init()
        self.coordinator = coordinator
        self.enterGroupUseCase = enterGroupUseCase
        self.setMyGroupUseCase = setMyGroupUseCase
        self.getMyGroupUseCase = getMyGroupUseCase
    }
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            Task {
                do {
                    // 재입장 시엔 null 반환하므로 입장 처리에만 사용
                    try await enterGroupUseCase.execute(inviteCode: state.inputText)
                    // 재입장 시를 위해 그룹 아이디 따로 요청
                    let group = try await getMyGroupUseCase.execute()
                    coordinator.popToRoot()
                    if let groupType = group.groupId {
                        setMyGroupUseCase.execute(groupId: groupType)
                    }
                } catch {
                    dump(error)
                }
            }
        }
    }
}
