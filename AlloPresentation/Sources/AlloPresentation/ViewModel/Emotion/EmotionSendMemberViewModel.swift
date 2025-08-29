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
        var housework: Housework
        var houseworkTitle: String = ""
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
    public init(coordinator: Coordinator, fetchMemberUscase: FetchMemberUseCase, housework: Housework) {
        self.coordinator = coordinator
        self.state = State(housework: housework)
        self.fetchMemberUseCase = fetchMemberUscase
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            guard let selectedMember = state.selectedMembers.first else { return }
            if state.housework.id != 0 { //집안일이 정해져있는 경우( 홈화면 ) -> 마음 선택 화면
                let sendEmotion = SendEmotion(
                    receiverId: selectedMember.id,
                    houseWorkId: state.housework.id,
                    disappointment: "",
                    compliments: []
                )
                coordinator.push(AppScene.emotionChoice(sendEmotion: sendEmotion, receiverName: selectedMember.name, houseworkTitle: state.housework.houseWorkName, receiverImg: selectedMember.profileImageUrl))
            } else {                                // 집안일이 정해져있지 않은 경우 (마음 탭)
                let sendEmotion = SendEmotion(
                    receiverId: selectedMember.id,
                    houseWorkId: 0,
                    disappointment: "",
                    compliments: []
                )
                coordinator.push(AppScene.houseworkSevendays(sendEmotion: sendEmotion, receiverName: selectedMember.name, houseworkTitle: "", receiverImg: selectedMember.profileImageUrl))
            }
        }
    }
    
    func fetchMembers() async {
        do {
            let members = try await fetchMemberUseCase.execute()
            /// 나 자신 저장
            let me = members.first
            /// 나 자신 제외한 멤버들만 state.members에
            if members.count > 1 {
                state.members = Array(members.dropFirst())
            } else {
                state.members = []
            }
            
        } catch {
            print("멤버 로드 실패: \(error)")
        }
    }
}
