//
//  AppCoordinator.swift
//  Allo
//
//  Created by 김민솔 on 8/9/25.
//

import SwiftUI
import AlloPresentation

@Observable
final class AppCoordinator: Coordinator {
    var diContainer: DIContainer
    var path = NavigationPath()
    var sheet: (any AppRoute)?
    var appSheet: AppSheet? {
        get { sheet as? AppSheet }
        set { sheet = newValue }
    }
    var fullScreenCover: (any AppRoute)?
    var appFullScreenCover: AppFullScreenCover? {
        get { fullScreenCover as? AppFullScreenCover }
        set { fullScreenCover = newValue }
    }
    var sheetOnDismiss: (() -> Void)?
    var fullScreenCoverOnDismiss: (() -> Void)?
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }
    @MainActor
    @ViewBuilder
    func buildScene(_ scene: AppScene, selectedTab: Binding<TabBarItem>? = nil) -> some View {
        switch scene {
        case .tabBar:
            TabBarView(selectedTab: selectedTab ?? .constant(.home))
        case .home:
            let homeViewModel = HomeViewModel(coordinator: self)
            HomeView(viewModel: homeViewModel)
        case .checklist:
            let checkListViewModel = CheckListViewModel(
                generateCalendarDateUseCase: diContainer.resolveGenerateCalendarDateUseCase(),
                completeHouseworkUseCase: diContainer.resolveCompleteHouseworkUseCase(),
                deleteHouseworkUseCase: diContainer.resolveDeleteHouseworkUseCase(),
                getHouseworkListUseCase: diContainer.resolveGetHouseworkListUseCase(),
                getHaveHouseworkUseCase: diContainer.resolveGetHaveHouseworkUseCase(),
                coordinator: self
            )
            CheckListView(viewModel: checkListViewModel)
        case .emotion:
            let emotionViewModel = EmotionViewModel(coordinator: self)
            EmotionView(viewModel: emotionViewModel)
        case .mypage:
            let mypageViewModel = MyPageViewModel(coordinator: self)
            MyPageView(viewModel: mypageViewModel)
        case .houseworkPlus:
            let addHouseworkViewModel = AddHouseworkViewModel(
                coordinator: self)
            AddHouseworkView(viewModel: addHouseworkViewModel)
        case .houseworkStandard(let housework):
            let addWorkstandardViewModel = AddWorkstandardViewModel(
                coordinator: self,
                housework: housework)
            AddWorkstandardView(viewModel: addWorkstandardViewModel)
        case .houseworkMember(let housework):
            let addWorkMemberViewModel = AddHouseworkMemberViewModel(
                coordinator: self,
                housework: housework, fetchMemberUscase: diContainer.resolveFetchMemberUseCase())
            AddHouseworkMemberView(viewModel: addWorkMemberViewModel)
        case .houseworkPlusFinish(let housework):
            let addHouseworkFinishViewModel = AddHouseworkFinishViewModel(
                coordinator: self,
                addHouseworkUseCase: diContainer.resolveAddHouseworkUsecase(),
                housework: housework
            )
            AddHouseworkFinishView(viewModel: addHouseworkFinishViewModel)

        }
    }
    
    @MainActor @ViewBuilder
    func buildSheet(_ sheet: AppSheet) -> some View {
        switch sheet {
        case .houseworkSelection(let worklistClickAction):
            HouseworkSelectionSheet(worklistClickAction: worklistClickAction)

        case .placeSelection(let placeClickAction):
            let viewModel = PlaceSelectionViewModel(
                coordinator: self,
                fetchPlacesUseCase: diContainer.resolveFetchPlaceUsecase()
            )
            PlaceSelectionSheet(coordinator: self, viewModel: viewModel, placeClickAction: placeClickAction)
                .presentationDetents([.height(624)])
        case .routineSelection(let completeButtonAction):
            RoutinesetSheet(completeButtonAction: completeButtonAction)
                .presentationDetents([.height(624)])
            
        case .calendarSelection(let dateClickAction):
            CalendarDateSheet(dateClickAction: dateClickAction)
                .presentationDetents([.height(624)])
        }
    }

    @MainActor @ViewBuilder
    func buildFullScreenCover(_ fullScreenCover: AppFullScreenCover) -> some View {
        switch fullScreenCover {
        case .addHousePlace:
            let viewModel = AddPlaceViewModel(coordinator: self)
            AddPlaceView(viewModel: viewModel)
        }
    }
}
