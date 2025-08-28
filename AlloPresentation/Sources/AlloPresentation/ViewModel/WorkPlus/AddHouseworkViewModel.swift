//
//  AddHouseworkViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/15/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class AddHouseworkViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var myHouseworkTitle: String
        var place: String
        var selectedPlaceId: Int?
        var startDate: String
        var endDate: String
        var routine: String
        var selectedDays: [String] = []
        var alarm: Bool
        var routineText: String
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapAddHouseworkButton
        case didTapAddPlaceButton
        case didTapAdddRoutineButton
        case didTapCalendarButton // 시작일/ 종료일
        case didTapNextButton
    }
    
    enum CalendarAction {
        case selectDate(date: Date)
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    // MARK: - Dependencies
    public init(coordinator: Coordinator) {
        let today = Date().toKoreanDateString()
        self.state = State(
            myHouseworkTitle: "",
            place: "방",
            startDate: today,
            endDate: today,
            routine: "반복안함",
            alarm: true,
            routineText: "반복안함"
        )
        self.coordinator = coordinator
    }
    
    //MARK: - Action Method
    func action(_ action: Action) {
        addHouseWorkAction(action)
    }
}

// MARK: Handling Actions
extension AddHouseworkViewModel {
    private func addHouseWorkAction(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapAddHouseworkButton:
            coordinator.presentSheet(AppSheet.houseworkSelection(worklistClickAction: { [weak self] selected in
                self?.state.myHouseworkTitle = selected
                self?.coordinator.dismissSheet()
            }),
                                     onDismiss: {})
        case .didTapAddPlaceButton:
            coordinator.presentSheet(
                AppSheet.placeSelection(initialPlace: state.place, placeClickAction: { [weak self] selected, placeId in
                    self?.state.place = selected
                    self?.state.selectedPlaceId = placeId
                    self?.coordinator.dismissSheet()
                }),
                onDismiss: {}
            )
        case .didTapAdddRoutineButton:
            coordinator.presentSheet(AppSheet.routineSelection(
                initialRoutine: state.routine,
                completeButtonAction: { [weak self] selected, selectedDays, routineText in
                    self?.state.routine = selected
                    self?.state.selectedDays = selectedDays   // 선택된 요일 저장
                    self?.state.routineText = routineText
                    self?.coordinator.dismissSheet()
                }
            ), onDismiss: {})

        case .didTapCalendarButton:
            coordinator.presentSheet(AppSheet.calendarSelection(dateSelectedAction: { [weak self] selected in
                self?.state.startDate = selected
                self?.state.endDate = selected
                self?.coordinator.dismissSheet()
            }), onDismiss: {})
        case .didTapNextButton:
            if let housework = makeHousework() {
                coordinator.push(AppScene.houseworkStandard(housework: housework))
            }
        }
    }
}

// MARK: - Function
extension AddHouseworkViewModel {
    func makeHousework() -> Housework? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd(EE)"
        guard let date = formatter.date(from: state.startDate) else { return nil }
        print("routine", state.routineEnum)
        print("dayOfTheWeek", state.selectedDays.map { $0.toDayOfWeek()})

        // 서버 전송용 데이터 생성
        let housework = Housework(
            houseWorkName: state.myHouseworkTitle,
            placeAdd: state.selectedPlaceId ?? 0,
            tagsAdd: [0],
            members: [0],
            startDate: state.startDate,
            dueDate: state.endDate,
            routineAdd: state.routineEnum,
            dayOfTheWeek: state.selectedDays.map { $0.toDayOfWeek() },
            isNotified: state.alarm
        )
        
        return housework
    }

}

extension Date {
    func toKoreanDateString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd(EE)"
        return formatter.string(from: self)
    }
}
extension AddHouseworkViewModel.State {
    var routineEnum: Routine {
        switch routine {
        case "반복안함":
            return .none
        case "매일":
            return .everyDay
        case "매주":
            return .everyWeek
        case "격주":
            return .biWeek
        default:
            return .none
        }
    }
}
extension String {
    func toDayOfWeek() -> AddDayOfTheWeek {
        switch self {
        case "월": return .monday
        case "화": return .tuesday
        case "수": return .wednesday
        case "목": return .thursday
        case "금": return .friday
        case "토": return .saturday
        case "일": return .sunday
        default: return .monday
        }
    }
}
