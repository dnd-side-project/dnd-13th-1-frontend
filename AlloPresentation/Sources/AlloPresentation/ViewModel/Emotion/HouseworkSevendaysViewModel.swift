//
//  HouseworkSevendaysViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI
import AlloDomain

@Observable
@MainActor
public final class HouseworkSevendaysViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var sendEmotion: SendEmotion
        var receiverName: String
        var houseworTitle: String
        var selectedHouseworks: Set<Int> = []
        var sevenDaysHouseworks: [HouseworkSevendays] = []
        var receiverImg: URL
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapNextButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    private let fetchDaysUscase: FetchHouseworkDaysUseCase
    public init(
        coordinator: Coordinator,
        fetchDaysUscase: FetchHouseworkDaysUseCase,
        sendEmotion: SendEmotion,
        receiverName: String,
        houseworTitle: String,
        receiverImg: URL
    ) {
        self.coordinator = coordinator
        self.state = State(sendEmotion: sendEmotion, receiverName: receiverName, houseworTitle: houseworTitle, receiverImg: receiverImg)
        self.fetchDaysUscase = fetchDaysUscase
    }

    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapNextButton:
            guard let houseworkId = state.selectedHouseworks.first else { return }
            let sendEmotion = SendEmotion(
                receiverId: state.sendEmotion.receiverId,
                houseWorkId: houseworkId,
                disappointment: "",
                compliments: []
            )
            coordinator.push(AppScene.emotionChoice(sendEmotion: sendEmotion, receiverName: state.receiverName, houseworkTitle: state.houseworTitle, receiverImg: state.receiverImg))
        }
    }
    
    public func loadSevenDaysHouseworks() async {
        do {
            let result = try await fetchDaysUscase.execute(receiverId: 2)
            self.state.sevenDaysHouseworks = result
        } catch {
            print("failed to fetch houseworks")
        }
    }
    
    func toggleHousework(_ housework: HouseworkRecent) {
        if state.selectedHouseworks.contains(housework.id) {
            state.selectedHouseworks.removeAll()
            state.houseworTitle = ""
        } else {
            state.selectedHouseworks = [housework.id]
            state.houseworTitle = housework.title
        }
    }

}
