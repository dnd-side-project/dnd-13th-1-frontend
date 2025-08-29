//
//  HouseworkDetailViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/29/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class HouseworkDetailViewModel: ViewModelable {
    struct State {
        var housework: Housework
    }
    
    enum Action {
        case didTapSendEmotion
        case didTapDeleteHousework
    }
    
    // MARK: - Dependencies
    private let getHouseworkDetailUseCase: GetHouseworkDetailUseCase
    private let deleteHouseworUseCase: DeleteHouseworkUseCase
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    
    // MARK: - Initializer
    public init(
        housework: Housework,
        getHouseworkDetailUseCase: GetHouseworkDetailUseCase,
        deleteHouseworUseCase: DeleteHouseworkUseCase,
        coordinator: Coordinator
    ) {
        self.getHouseworkDetailUseCase = getHouseworkDetailUseCase
        self.deleteHouseworUseCase = deleteHouseworUseCase
        self.coordinator = coordinator
        self.state = State(housework: housework)
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapSendEmotion:
            coordinator.dismissSheet()
            Task {
                try? await Task.sleep(nanoseconds: 300_000_000)
                sendEmotion(housework: state.housework)
            }
        case .didTapDeleteHousework:
            Task {
                await deleteHousework(housework: state.housework)
            }
            coordinator.dismissSheet()
        }
    }
}

// MARK: - Loading
extension HouseworkDetailViewModel {
    func loadHouseworkDetail(houseworkId: Int) async {
        do {
            let detail = try await getHouseworkDetailUseCase.execute(id: 2)
            // HouseworkDetail → Housework 변환
            let housework = Housework(
                id: detail.id,
                place: detail.placeName,
                title: detail.title,
                member: detail.members.map { m in
                    Member(
                        id: m.id,
                        name: m.name,
                        profileImageUrl: URL(string: "https://example.com/placeholder.png")!
                    )
                },
                date: detail.date,
                isDone: false,
                routine: .none,
                tags: detail.tags
            )
            
            await MainActor.run {
                self.state.housework = housework
            }
        } catch {
            print("Housework detail load failed: \(error)")
        }
    }

    func sendEmotion(housework: Housework) {
        let housework = Housework(
            id: 3,
            place: "",
            title: state.housework.houseWorkName,
            member: [],
            date: Date(),
            isDone: false,
            routine: .none,
            tags: []
        )
        coordinator.push(AppScene.emotionMember(housework: housework))
    }
    
    func deleteHousework(housework: Housework) async {
        do {
           try await deleteHouseworUseCase.execute(housework)
        } catch {
            // fail
        }
    }
}
