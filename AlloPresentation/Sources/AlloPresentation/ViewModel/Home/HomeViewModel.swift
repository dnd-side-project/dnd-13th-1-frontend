//
//  HomeViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import SwiftUI
import AlloDomain

@Observable
public final class HomeViewModel: ViewModelable {
    struct State {
        let groupType: GroupType // 그룹 타입 - 배경색
        let characterStatus: CharacterStatus // 캐릭터 상태
        let completedHouseworks: Int // 오늘의 공동 집안일 - 수행
        let totalHouseworks: Int // 오늘의 공동 집안일 - 전체
        let cleanliness: Int // 청결도
        let recentHouseworks: [Housework] // 마음 보내기 - 최근 7일 집안일
        let houseworkPlaces: [String: [Housework]] // 장소별 집안일
        var isBottomSheetPresented: Bool
        var isCharacterStatusSheetPresented: Bool
    }
    enum Action {
        case didTapMemberButton
        case didTapNotificationButton
        case didTapCharacterMessage
        case didTapCharacterStatusBar
        case didTapEmotionCardList
        case didTapSendEmotion(Housework)
        case didTapAddHousework
    }
    var isLoading: Bool = true
    var state: State
    let coordinator: Coordinator
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.state = State(
            groupType: .roommate,
            characterStatus: .bored,
            completedHouseworks: 0,
            totalHouseworks: 0,
            cleanliness: 0,
            recentHouseworks: [],
            houseworkPlaces: [:],
            isBottomSheetPresented: true,
            isCharacterStatusSheetPresented: false
        )
        self.isLoading = false
    }
    func action(_ action: Action) {
        switch action {
        case .didTapMemberButton:
            break
        case .didTapNotificationButton:
            break
        case .didTapCharacterMessage:
            break
        case .didTapCharacterStatusBar:
            state.isCharacterStatusSheetPresented = true
        case .didTapEmotionCardList:
            break
        case let .didTapSendEmotion(housework):
            break
        case .didTapAddHousework:
            break
        }
    }
}
