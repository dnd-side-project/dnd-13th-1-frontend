//
//  AddHouseworkViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/15/25.
//

import SwiftUI
import AlloDomain

@MainActor
@Observable
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
        var isNewPlaceSelected: Bool = false
    }

    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapAddHouseworkButton
        case didTapAddPlaceButton
        case didTapAdddRoutineButton
        case didTapCalendarButton
        case didTapNextButton
    }

    // MARK: - Properties
    var state: State
    let coordinator: Coordinator

    // MARK: - Init
    public init(coordinator: Coordinator) {
        let today = Date().toKoreanDateString()
        self.state = State(
            myHouseworkTitle: "",
            place: "",
            startDate: today,
            endDate: today,
            routine: "반복안함",
            alarm: true,
            routineText: "반복안함"
        )
        self.coordinator = coordinator
        NotificationCenter.default.addObserver(
            forName: .newPlaceAdded,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            guard let self = self,
                  let newPlace = notification.userInfo?["place"] as? HouseworkPlace else { return }
            Task { @MainActor in
                self.state.place = newPlace.name
                self.state.selectedPlaceId = newPlace.placeId
                self.state.isNewPlaceSelected = true
                print("새로 추가된 장소 수신:", newPlace.name, newPlace.placeId)
            }
        }
    }

    // MARK: - Action Handler
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()

        case .didTapAddHouseworkButton:
            coordinator.presentSheet(
                AppSheet.houseworkSelection(worklistClickAction: { [weak self] selected in
                    self?.state.myHouseworkTitle = selected
                    self?.coordinator.dismissSheet()
                }),
                onDismiss: {}
            )

        case .didTapAddPlaceButton:
            // 기존 장소 선택 vs 새 장소 추가 구분
            coordinator.presentSheet(
                AppSheet.placeSelection(
                    initialPlace: state.place,
                    placeClickAction: { [weak self] selected, placeId in
                        Task { @MainActor in
                            guard let self = self else { return }
                            self.state.place = selected
                            self.state.selectedPlaceId = placeId
                            self.state.isNewPlaceSelected = false
                            self.coordinator.dismissSheet()
                            print("✅ 기존 장소 선택:", selected, placeId)
                        }
                    }
                ),
                onDismiss: {}
            )

        case .didTapAdddRoutineButton:
            coordinator.presentSheet(
                AppSheet.routineSelection(
                    initialRoutine: state.routine,
                    completeButtonAction: { [weak self] selected, selectedDays, routineText in
                        Task { @MainActor in
                            guard let self = self else { return }
                            self.state.routine = selected
                            self.state.selectedDays = selectedDays
                            self.state.routineText = routineText
                            self.coordinator.dismissSheet()
                        }
                    }
                ),
                onDismiss: {}
            )

        case .didTapCalendarButton:
            coordinator.presentSheet(
                AppSheet.calendarSelection(dateSelectedAction: { [weak self] selected in
                    Task { @MainActor in
                        guard let self = self else { return }
                        self.state.startDate = selected
                        self.state.endDate = selected
                        self.coordinator.dismissSheet()
                    }
                }),
                onDismiss: {}
            )

        case .didTapNextButton:
            if let housework = makeHousework() {
                coordinator.push(AppScene.houseworkStandard(housework: housework))
            }
        }
    }

    // MARK: - Function
    func makeHousework() -> Housework? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd(EE)"
        guard let _ = formatter.date(from: state.startDate) else { return nil }
        let placeIdToUse = state.selectedPlaceId ?? 0
        let housework = Housework(
            id: 0,
            place: state.place,
            title: state.myHouseworkTitle,
            member: [],
            date: Date(),
            isDone: false,
            routine: HouseworkRoutine(rawValue: state.routine) ?? .none,
            tags: [],
            houseWorkName: state.myHouseworkTitle,
            placeAdd: placeIdToUse,
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

// MARK: - Extensions
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
        case "반복안함": return .none
        case "매일": return .everyDay
        case "매주": return .everyWeek
        case "격주": return .biWeek
        default: return .none
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
