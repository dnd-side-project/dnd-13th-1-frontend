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
        var startDate: String
        var endDate: String
        var routine: String
        var alarm: Bool
    }
    // MARK: - Action
    enum Action {
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
    private let addHouseworkUseCase: AddHouseworkUseCase
    public init(addHouseworkUseCase: AddHouseworkUseCase, coordinator: Coordinator) {
        let today = Date().toKoreanDateString()
        self.state = State(
            myHouseworkTitle: "",
            place: "방",
            startDate: today,
            endDate: today,
            routine: "반복안함",
            alarm: true
        )
        self.addHouseworkUseCase = addHouseworkUseCase
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
        case .didTapAddHouseworkButton:
            coordinator.presentSheet(AppSheet.houseworkSelection(worklistClickAction: { [weak self] selected in
                self?.state.myHouseworkTitle = selected
                self?.coordinator.dismissSheet()
            }),
                                     onDismiss: {})
        case .didTapAddPlaceButton:
            coordinator.presentSheet(AppSheet.placeSelection(placeClickAction: { [weak self] selected in
                self?.state.place = selected
                self?.coordinator.dismissSheet()
            }),
                                     onDismiss: {})
        case .didTapAdddRoutineButton:
            coordinator.presentSheet(AppSheet.routineSelection(completeButtonAction: { [weak self] selected in
                self?.state.routine = selected
                self?.coordinator.dismissSheet()
            }),
                                     onDismiss: {})
        case .didTapCalendarButton:
            coordinator.presentSheet(AppSheet.calendarSelection(dateSelectedAction: { [weak self] selected in
                self?.state.startDate = selected
                self?.state.endDate = selected
                self?.coordinator.dismissSheet()
            }), onDismiss: {})
        case .didTapNextButton:
            coordinator.push(AppScene.houseworkStandard(myHouseworkTitle: state.myHouseworkTitle))
        }
    }
}

// MARK: - Function
extension AddHouseworkViewModel {
}

// MARK: - API Calls
extension AddHouseworkViewModel {
    
}
extension Date {
    func toKoreanDateString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd(EE)"
        return formatter.string(from: self)
    }
}
