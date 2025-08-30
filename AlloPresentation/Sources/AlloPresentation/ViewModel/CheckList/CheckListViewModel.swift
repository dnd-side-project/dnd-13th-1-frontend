//
//  CheckListViewModel.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/9/25.
//

import Foundation
import AlloDomain

@Observable
@MainActor
public final class CheckListViewModel: ViewModelable {
    // MARK: - State
    /// 한 뷰에 다양한 기능이 있으므로 캘린더와 체크리스트로 내부적으로 분리하여 관리합니다
    /// - Note: 뷰모델을 분리하여도 되나, 뷰모델 간의 양방향 의존성이 생길 수 있음을 주의해야합니다
    struct State {
        var isLoading: Bool
        var calendarState: CalendarState
        var checkListState: CheckListState
    }
    struct CalendarState {
        /// 무한 스크롤을 위한 3주의 날짜 데이터
        /// Bool : 집안일 존재 여부
        var pastWeek: [Date: Bool]
        var presentWeek: [Date: Bool]
        var futureWeek: [Date: Bool]
        /// n월 n주차
        var weekString: String
        /// 유저의 선택 상태
        var selectedDate: Date
        var selectedDayOfTheWeek: DayOfTheWeek
        var selectedDateOnDatePicker: Date
        /// 무한 스크롤 뷰를 위한 변수
        var scrollPosition: Int?
        /// 데이트 피커 표시 여부
        var showDatePicker: Bool
    }
    struct CheckListState {
        var myHouseworksLeft: [Housework] // 해당 날짜의 미완료 나의 집안일
        var ourHouseworksLeft: [Housework] // 해당 날짜의 미완료 우리집 집안일
        var myHouseworksCompleted: [Housework] // 해당 날짜의 완료 나의 집안일
        var ourHouseworksCompleted: [Housework] // 해당 날짜의 완료 우리집 집안일
        var selectedHouseworks: [Housework] // 선택한 집안일
        var showsCompleted: Bool // 완료한 집안일 아코디언 리스트
        var selectedTabIndex: Int // 0(나의 집안일), 1(우리집 집안일)
        var isEditing: Bool // 편집 상태
    }
    // MARK: - Action
    enum Action {
        case weekCalendarAction(WeekCalendarAction) // 주간 캘린더 관련 유저 액션
        case datePickerAction(DatePickerAction) // 데이트피커 관련 유저 액션
        case checkListAction(CheckListAction) // 체크리스트 관련 유저 액션
        case didTapMemberButton // 멤버 버튼 탭
        case didTapNotificationButton // 알림 버튼 탭
    }
    enum WeekCalendarAction {
        case selectDate(_ date: Date)
        case moveToPast
        case moveToFuture
        case didTapTodayButton
    }
    enum DatePickerAction {
        case willPresentDatePicker
        case selectDate(_ date: Date)
        case didTapPreviousMonth
        case didTapNextMonth
        case didTapSelectButton
        case willCloseDatePicker
    }
    enum CheckListAction {
        case selectTab(_ index: Int)
        case completeHousework(_ housework: Housework)
        case selectHousework(_ housework: Housework)
        case startEditing
        case deleteSelectedHousework
        case finishEditing
        case didTapAddHouseworkButton
        case didTapCompletedHouseworkListButton
        case didTaphousework(_ housework: Housework)
    }
    // MARK: - Dependencies
    private let generateCalendarDateUseCase: GenerateCalendarDateUseCase
    private let completeHouseworkUseCase: CompleteHouseworkUseCase
    private let deleteHouseworkUseCase: DeleteHouseworkUseCase
    private let getHouseworkListUseCase: GetHouseworkListUseCase
    private let getHaveHouseworkUseCase: GetHaveHouseworkUseCase
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    // MARK: - Initializer
    public init(
        generateCalendarDateUseCase: GenerateCalendarDateUseCase,
        completeHouseworkUseCase: CompleteHouseworkUseCase,
        deleteHouseworkUseCase: DeleteHouseworkUseCase,
        getHouseworkListUseCase: GetHouseworkListUseCase,
        getHaveHouseworkUseCase: GetHaveHouseworkUseCase,
        coordinator: Coordinator
    ) {
        self.generateCalendarDateUseCase = generateCalendarDateUseCase
        self.completeHouseworkUseCase = completeHouseworkUseCase
        self.deleteHouseworkUseCase = deleteHouseworkUseCase
        self.getHouseworkListUseCase = getHouseworkListUseCase
        self.getHaveHouseworkUseCase = getHaveHouseworkUseCase
        self.state = State(
            isLoading: false,
            calendarState: .init(
                pastWeek: [:],
                presentWeek: [:],
                futureWeek: [:],
                weekString: "",
                selectedDate: Date(),
                selectedDayOfTheWeek: .friday,
                selectedDateOnDatePicker: Date(),
                showDatePicker: false
            ),
            checkListState: .init(
                myHouseworksLeft: [],
                ourHouseworksLeft: [],
                myHouseworksCompleted: [],
                ourHouseworksCompleted: [],
                selectedHouseworks: [],
                showsCompleted: false,
                selectedTabIndex: 0,
                isEditing: false
            )
        )
        self.coordinator = coordinator
    }
    // MARK: - Action Method
    func action(_ action: Action) {
        switch action {
        case let .weekCalendarAction(action):
            handleWeekCalendarAction(action)
        case let .datePickerAction(action):
            handleDatePickerAction(action)
        case let .checkListAction(action):
            handleCheckListAction(action)
        case .didTapNotificationButton:
            break
            // TODO: 알림 UI 전환
        case .didTapMemberButton:
            coordinator.push(AppScene.homeMember)
        }
    }
}

// MARK: Handling Actions
extension CheckListViewModel {
    private func handleWeekCalendarAction(_ action: WeekCalendarAction) {
        switch action {
        case let .selectDate(date):
            updateDataOnNewWeeks(date)
        case .moveToPast:
            updateDataOnNewWeeks(state.calendarState.selectedDate.adding(days: -7))
        case .moveToFuture:
            updateDataOnNewWeeks(state.calendarState.selectedDate.adding(days: +7))
        case .didTapTodayButton: // 초기에도 적용
            updateDataOnNewWeeks(Date())
        }
    }
    
    private func handleDatePickerAction(_ action: DatePickerAction) {
        switch action {
        case .willPresentDatePicker:
            state.calendarState.showDatePicker = true
        case let .selectDate(date):
            state.calendarState.selectedDateOnDatePicker = date
        case .didTapPreviousMonth:
            // TODO: DatePicker 구현 필요
            break
        case .didTapNextMonth:
            // TODO: DatePicker 구현 필요
            break
        case .didTapSelectButton:
            updateDataOnNewWeeks(state.calendarState.selectedDateOnDatePicker)
        case .willCloseDatePicker:
            state.calendarState.showDatePicker = false
        }
    }
    
    private func handleCheckListAction(_ action: CheckListAction) {
        switch action {
        case let .selectTab(index):
            state.checkListState.selectedTabIndex = index
        case let .completeHousework(housework):
            Task {
                do {
                    try await completeHousework(housework)
                    state.checkListState.myHouseworksLeft.removeAll(where: { $0.id == housework.id })
                    state.checkListState.ourHouseworksLeft.removeAll(where: { $0.id == housework.id })
                } catch(let error) {
                    dump(#function)
                    dump(error)
                }
            }
        case let .selectHousework(housework):
            if let index = state.checkListState.selectedHouseworks.firstIndex(of: housework) {
                state.checkListState.selectedHouseworks.remove(at: index) // 선택 취소(다시 탭)
            } else {
                state.checkListState.selectedHouseworks.append(housework) // 선택 추가
            }
        case .startEditing:
            state.checkListState.isEditing = true
        case .deleteSelectedHousework:
            Task {
                do {
                    // TODO: 집안일 삭제 유즈케이스 호출
                } catch(let error) {
                    dump(#function)
                    dump(error)
                }
            }
        case .finishEditing:
            state.checkListState.selectedHouseworks.removeAll()
            state.checkListState.isEditing = false
        case .didTapAddHouseworkButton:
            coordinator.push(AppScene.houseworkPlus)
        case .didTapCompletedHouseworkListButton:
            state.checkListState.showsCompleted.toggle()
        case let .didTaphousework(housework):
            let dummyHousework = housework
            coordinator.presentSheet(
                AppSheet.houseworkDetailSelection(housework: dummyHousework) {
                    self.coordinator.dismissSheet()
                },
                onDismiss: {}
            )
        }
    }
}

// MARK: - Functions
extension CheckListViewModel {
    /// 3주의 집안일 존재 여부를 캘린더에 반영하고, 해당 날짜의 집안일 데이터를 업데이트합니다
    func updateDataOnNewWeeks(_ baseDate: Date) {
        state.isLoading = true
        defer { state.isLoading = false }
        Task {
            do {
                /// 3주 날짜 데이터를 생성합니다
                let (pastWeek, presentWeek, futureWeek) = generateCalendarDateUseCase.execute(baseDate)
                /// async let - await를 사용하여 비동기 작업들이 병렬적으로 실행하되, 모두 완료된 후 상태를 업데이트하도록 보장합니다
                /// 선택한 날짜의 집안일 목록을 가져와 state에 반영합니다
                async let update: () = await updateHouseworkListOn(baseDate)
                /// 집안일 존재 여부를 조회하고 state에 반영합니다
                async let data = try await fetchHaveHouseworkOn(from: pastWeek[0], to: futureWeek[6])
                let ((), houseworkData) = try await (update, data)
                /// 3주의 집안일 정보를 매핑합니다
                state.calendarState.pastWeek = Dictionary(
                    uniqueKeysWithValues: pastWeek.map {
                        ($0, houseworkData[$0] ?? false)
                    }
                )
                state.calendarState.presentWeek = Dictionary(
                    uniqueKeysWithValues: presentWeek.map {
                        ($0, houseworkData[$0] ?? false)
                    }
                )
                state.calendarState.futureWeek = Dictionary(
                    uniqueKeysWithValues: futureWeek.map {
                        ($0, houseworkData[$0] ?? false)
                    }
                )
                /// 날짜 선택 상태를 달력에 반영합니다
                state.calendarState.selectedDate = baseDate
                state.calendarState.selectedDayOfTheWeek = baseDate.getDayOfTheWeek()
                state.calendarState.weekString = presentWeek[0].getWeekString()
                /// 무한 스크롤을 위해 스크롤 포지션을 초기화합니다
                state.calendarState.scrollPosition = 0
            } catch(let error) {
                dump(#function)
                dump(error)
            }
        }
    }
    /// 특정 날짜의 집안일 데이터를 업데이트합니다
    private func updateHouseworkListOn(_ date: Date) async {
        Task {
            do {
                let houseworkList = try await fetchHouseworkListOn(date)
                state.checkListState.myHouseworksLeft = houseworkList.myHouseworksLeft
                state.checkListState.ourHouseworksLeft = houseworkList.ourHouseworksLeft
                state.checkListState.myHouseworksCompleted = houseworkList.myHouseworksCompleted
                state.checkListState.ourHouseworksCompleted = houseworkList.ourHouseworksCompleted
            } catch(let error) {
                dump(#function)
                dump(error)
            }
        }
    }
}

// MARK: - API Calls
extension CheckListViewModel {
    func fetchHaveHouseworkOn(from: Date, to: Date) async throws -> [Date: Bool] {
        try await getHaveHouseworkUseCase.execute(from: from, to: to)
    }
    func fetchHouseworkListOn(_ date: Date) async throws -> (
        myHouseworksLeft: [Housework],
        ourHouseworksLeft: [Housework],
        myHouseworksCompleted: [Housework],
        ourHouseworksCompleted: [Housework]
    ) {
        try await getHouseworkListUseCase.execute(date)
    }
    func completeHousework(_ housework: Housework) async throws {
        try await completeHouseworkUseCase.execute(housework)
    }
}
