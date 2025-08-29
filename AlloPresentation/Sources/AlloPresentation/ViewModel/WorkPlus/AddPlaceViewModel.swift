//
//  AddPlaceViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/18/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class AddPlaceViewModel: ViewModelable {
    struct State {
        var newPlaceName: String = ""
        var existingPlaces: [String] = []
        var groupId: String? = ""
    }

    var state: State
    let coordinator: Coordinator
    let usecase: AddPlaceUseCase

    // MARK: - Init
    public init(coordinator: Coordinator, usecase: AddPlaceUseCase, existingPlaces: [String] = []) {
        self.coordinator = coordinator
        self.usecase = usecase
        self.state = State(existingPlaces: existingPlaces)
    }

    enum Action {
        case didTapBackButton
        case didTapAddPlaceButton
    }

    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.dismissFullScreenCover()
        case .didTapAddPlaceButton:
            Task { await addPlace() }
        }
    }

    private func addPlace() async {
        guard !state.newPlaceName.isEmpty else { return }

        do {
            // 서버에 요청해서 response 받기
            let response = try await usecase.execute(placeName: state.newPlaceName)

            // 실제 서버에서 받은 placeId와 name 사용
            let newPlace = HouseworkPlace(placeId: response.placeId, name: response.name)

            // 기존 리스트에 추가
            state.existingPlaces.append(newPlace.name)
            state.newPlaceName = ""

            // 화면 닫기
            coordinator.dismissFullScreenCover()
            NotificationCenter.default.post(
                name: .newPlaceAdded,
                object: nil,
                userInfo: ["place": newPlace]
            )

        } catch {
            print("장소 추가 실패: \(error)")
        }
    }
}

// Notification 이름 정의
extension Notification.Name {
    static let newPlaceAdded = Notification.Name("newPlaceAdded")
}
