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
        var customTag: TagList?
        var fetchedTags: [TagList] = []
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
    let tagUseCase: TagListUseCase
    let addTagUseCase: TagAddUseCase
    public init(coordinator: Coordinator, housework: Housework, tagUseCase: TagListUseCase, addTagUseCase: TagAddUseCase) {
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
                    // 1. 선택된 서버 태그 이름 → tagId 변환
                    let selectedTagIds = state.selectedStandards.compactMap { selectedName in
                        state.fetchedTags.first(where: { $0.name == selectedName })?.tagId
                    }
                    
                    // 2. 커스텀 태그 서버에 추가 후 tagId 반환
                    var createdCustomTagIds: [Int] = []
                    for customTag in state.customTags {
                        let newTag = try await addTagUseCase.execute(groupId: 123, tagName: customTag)
                        createdCustomTagIds.append(newTag.tagId)
                    }
                    
                    // 3. 최종 tagId 배열
                    let allTagIds = selectedTagIds + createdCustomTagIds
                    let allTags = state.selectedStandards + state.customTags
                    // 4. Housework 업데이트
                    let updatedHousework = Housework(
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
    
    public func loadTags(groupId: Int) async {
        do {
            let fetchedTags = try await tagUseCase.execute(groupId: groupId)
            await MainActor.run {
                state.fetchedTags = fetchedTags
                print("로드된 태그:", fetchedTags.map { $0.name })
            }
        } catch {
            print("tag 불러오기 실패: \(error)")
        }
    }

    
    public func addTags(groupId: Int, tagName: String) async {
        do {
            let addTags = try await addTagUseCase.execute(groupId: groupId, tagName: tagName)
            state.customTag = addTags
        } catch {
            print("tag 추가 실패: \(error)")
        }
    }
}
