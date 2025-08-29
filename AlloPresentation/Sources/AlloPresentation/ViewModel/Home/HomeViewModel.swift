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
        var groupType: GroupType // 그룹 타입 - 배경색
        var characterStatus: CharacterStatus // 캐릭터 상태
        var completedHouseworks: Int // 오늘의 공동 집안일 - 수행
        var totalHouseworks: Int // 오늘의 공동 집안일 - 전체
        var cleanliness: Int // 청결도
        var recentHouseworks: [Housework] // 마음 보내기 - 최근 7일 집안일
        var houseworkPlaces: [String: [Housework]] // 장소별 집안일
        var isBottomSheetPresented: Bool
        var isCharacterStatusSheetPresented: Bool
    }
    enum Action {
        case load
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
    private let getGroupStateUseCase: GetGroupStateUseCase
    private let getMyGroupUseCase: GetMyGroupUseCase
    private let fetchPlacesUseCase: FetchPlacesUseCase
    private let getTodayPlaceHouseworkUseCase: GetTodayPlaceHouseworkUseCase
    private let getTodayCompletionStatusUseCase: GetTodayCompletionStatusUseCase
    
    public init(coordinator: Coordinator, getGroupStateUseCase: GetGroupStateUseCase, getMyGroupUseCase: GetMyGroupUseCase, fetchPlacesUseCase: FetchPlacesUseCase, getTodayPlaceHouseworkUseCase: GetTodayPlaceHouseworkUseCase, getTodayCompletionStatusUseCase: GetTodayCompletionStatusUseCase) {
        self.coordinator = coordinator
        self.getGroupStateUseCase = getGroupStateUseCase
        self.getMyGroupUseCase = getMyGroupUseCase
        self.fetchPlacesUseCase = fetchPlacesUseCase
        self.getTodayPlaceHouseworkUseCase = getTodayPlaceHouseworkUseCase
        self.getTodayCompletionStatusUseCase = getTodayCompletionStatusUseCase
        self.state = State(
            groupType: .roommate,
            characterStatus: CharacterStatus(cleanliness: 0, state: "심심한 상태에요", message: "어서와~ 집안일을 등록해봐!"),
            completedHouseworks: 0,
            totalHouseworks: 0,
            cleanliness: 0,
            recentHouseworks: [],
            houseworkPlaces: [:],
            isBottomSheetPresented: true,
            isCharacterStatusSheetPresented: false
        )
    }
    func action(_ action: Action) {
        switch action {
        case .load:
            Task {
                do {
                    let groupInfo = try await getMyGroupUseCase.execute()
                    let complete = try await getTodayCompletionStatusUseCase.execute()
                    let groupState = try await getGroupStateUseCase.execute(groupId: groupInfo.groupId ?? 0)
                    
                    // 장소 목록 조회
                    let places = try await fetchPlacesUseCase.execute()
                    
                    // 각 장소별로 오늘의 할 일 조회
                    var placeHouseworks: [String: [Housework]] = [:]
                    
                    for place in places {
                        let todayPlaceHousework = try await getTodayPlaceHouseworkUseCase.execute(placeId: place.placeId)
                        
                        // 개인 집안일과 공동 집안일을 합쳐서 해당 장소의 모든 집안일로 설정
                        var allHouseworks: [Housework] = []
                        
                        // 개인 집안일 추가
                        for item in todayPlaceHousework.my {
                            let housework = Housework(
                                id: item.id,
                                place: place.name,
                                title: item.title,
                                member: [],
                                date: Date(),
                                isDone: false,
                                routine: .none,
                                tags: [],
                                houseWorkName: item.title,
                                placeAdd: place.placeId,
                                tagsAdd: [],
                                members: [],
                                startDate: "",
                                dueDate: "",
                                routineAdd: .none,
                                dayOfTheWeek: [],
                                isNotified: false
                            )
                            allHouseworks.append(housework)
                        }
                        
                        // 공동 집안일 추가
                        for item in todayPlaceHousework.our {
                            let housework = Housework(
                                id: item.id,
                                place: place.name,
                                title: item.title,
                                member: [],
                                date: Date(),
                                isDone: false,
                                routine: .none,
                                tags: [],
                                houseWorkName: item.title,
                                placeAdd: place.placeId,
                                tagsAdd: [],
                                members: [],
                                startDate: "",
                                dueDate: "",
                                routineAdd: .none,
                                dayOfTheWeek: [],
                                isNotified: false
                            )
                            allHouseworks.append(housework)
                        }
                        
                        placeHouseworks[place.name] = allHouseworks
                    }
                    
                    let characterStatus = CharacterStatus(
                        cleanliness: groupState.cleanliness,
                        state: groupState.state,
                        message: groupState.message
                    )
                    
                    state.completedHouseworks = complete.completed
                    state.totalHouseworks = complete.completed + complete.left
                    state.groupType = groupInfo.groupType ?? .roommate
                    state.cleanliness = groupState.cleanliness
                    state.characterStatus = characterStatus
                    state.houseworkPlaces = placeHouseworks
                    state.isBottomSheetPresented = true
                    isLoading = false
                } catch {
                    dump(error)
                }
            }
        case .didTapMemberButton:
            coordinator.push(AppScene.homeMember)
            state.isBottomSheetPresented = false
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
