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
            // 선택된 멤버 id 추출
            let selectedMemberIds = state.selectedMembers.map { $0.id }
            // TODO: 태그 id 추출, 현재 임시로 [0] 사용
            let selectedTagIds: [Int] = [0]
            
            // 서버 전송용 Housework 생성
            let housework = Housework(
                houseWorkName: state.housework.title,
                placeAdd: 0,                  // 선택된 place index
                tagsAdd: selectedTagIds,
                members: selectedMemberIds,
                startDate: state.housework.startDate,
                dueDate: state.housework.dueDate,
                routineAdd: state.housework.routineAdd,
                dayOfTheWeek: state.housework.dayOfTheWeek,
                isNotified: state.housework.isNotified
            )
            
            // 화면 이동 시 서버 전송용 Housework 전달
            coordinator.push(AppScene.houseworkPlusFinish(housework: housework))

        }
    }
    
    func fetchMembers(groupId: Int) async {
        do {
            let members = try await fetchMemberUseCase.execute(groupId: groupId)
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
