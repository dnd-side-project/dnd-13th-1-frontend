//
//  AddWorkstandardViewModel.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/17/25.
//

import SwiftUI
import AlloDomain
import Observation

@Observable
public final class AddWorkstandardViewModel: ViewModelable {
    // MARK: - State
    struct State {
        var housework: Housework
        var selectedStandards: [String] = []
        var customTags: [String] = []
        var customTag: TagItem?
        var fetchedTags: [TagItem] = []
    }
    // MARK: - Action
    enum Action {
        case didTapBackButton
        case didTapTagButton
        case didTapNextButton
    }
    // MARK: - Properties
    var state: State
    let coordinator: Coordinator
    let tagUseCase: FetchTagsUseCase
    let addTagUseCase: AddTagUseCase
    public init(coordinator: Coordinator, housework: Housework, tagUseCase: FetchTagsUseCase, addTagUseCase: AddTagUseCase) {
        self.coordinator = coordinator
        self.state = State(housework: housework)
        self.tagUseCase = tagUseCase
        self.addTagUseCase = addTagUseCase
    }
    
    func action(_ action: Action) {
        switch action {
        case .didTapBackButton:
            coordinator.pop()
        case .didTapTagButton:
            coordinator.popToRoot()
        case .didTapNextButton:
            Task { @MainActor in
                do {
                    /// 1. 선택된 서버 태그 이름 → tagId 변환
                    let selectedTagIds = state.selectedStandards.compactMap { selectedName in
                        state.fetchedTags.first(where: { $0.name == selectedName })?.id
                    }
                    /// 2. 커스텀 태그 서버에 추가 후 tagId 반환
                    var createdCustomTagIds: [Int] = []
                    for customTag in state.customTags {
                        /// 중복 방지 조건
                        let isDuplicate = state.fetchedTags.contains { $0.name == customTag }
                        if isDuplicate { continue }
                        
                        let newTag = try await addTagUseCase.execute(name: customTag)
                        createdCustomTagIds.append(newTag.id)
                    }
                    /// 3. 최종 tagId 배열
                    let allTagIds = selectedTagIds + createdCustomTagIds
                    let allTags = state.selectedStandards + state.customTags
                    /// 4. Housework 업데이트
                    let updatedHousework = Housework(
                        id: 0,
                        place: state.housework.place,
                        title: state.housework.title,
                        member: [],
                        date: Date(),
                        isDone: false,
                        routine: .none,
                        tags: allTags,
                        houseWorkName: state.housework.houseWorkName,
                        placeAdd: state.housework.placeAdd,
                        tagsAdd: allTagIds,
                        members: state.housework.members,
                        startDate: state.housework.startDate,
                        dueDate: state.housework.dueDate,
                        routineAdd: state.housework.routineAdd,
                        dayOfTheWeek: state.housework.dayOfTheWeek,
                        isNotified: state.housework.isNotified
                    )
                    
                    coordinator.push(AppScene.houseworkMember(housework: updatedHousework))
                } catch {
                    print("태그 생성 실패:", error)
                }
            }
        }
    }
    
    public func loadTags() async {
        do {
            let fetchedTags = try await tagUseCase.execute()
            await MainActor.run {
                state.fetchedTags = fetchedTags
                print("로드된 태그:", fetchedTags.map { $0.name })
            }
        } catch {
            print("tag 불러오기 실패: \(error)")
        }
    }
}
