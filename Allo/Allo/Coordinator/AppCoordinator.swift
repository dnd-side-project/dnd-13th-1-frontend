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
        case let .home(selectedTab): // Binding이 필요하기 때문에 따로 관리
            let homeViewModel = HomeViewModel(coordinator: self)
            HomeView(viewModel: homeViewModel, selectedTab: selectedTab)
        case .tabBar, .checklist, .mypage:
            buildTabScene(scene, selectedTab: selectedTab)
        case .houseworkPlus, .houseworkStandard, .houseworkMember, .houseworkPlusFinish, .houseworkSevendays:
            buildHouseworkScene(scene)
        case .emotion, .emotionMember, .emotionChoice, .emotionThankMessage, .emotionRegretMessage, .emotionFinish, .emotionDetails:
            buildEmotionScene(scene)
        }
    }
    
    @MainActor
    @ViewBuilder
    private func buildTabScene(_ scene: AppScene, selectedTab: Binding<TabBarItem>? = nil) -> some View {
        switch scene {
        case .tabBar:
            TabBarView(selectedTab: selectedTab ?? .constant(.home))
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
        case .mypage:
            let mypageViewModel = MyPageViewModel(
                fetchMemberUseCase: diContainer.resolveFetchMemberUseCase(),
                getActivitySummaryUseCase: diContainer.resolveGetActivitySummaryUseCase(),
                getTodayCompletionStatusUseCase: diContainer.resolveGetTodayCompletionStatusUseCase(),
                getMyContributionUseCase: diContainer.resolveGetMyContributionUseCase(),
                getWeekCompletionStatusUseCase: diContainer.resolveGetWeekCompletionStatusUseCase(),
                getTwoWeekComparisonUseCase: diContainer.resolveGetTwoWeekComparisonUseCase(),
                coordinator: self
            )
            MyPageView(viewModel: mypageViewModel)
        default:
            EmptyView()
        }
    }
    
    @MainActor
    @ViewBuilder
    private func buildHouseworkScene(_ scene: AppScene) -> some View {
        switch scene {
        case .houseworkPlus:
            AddHouseworkView(viewModel: AddHouseworkViewModel(coordinator: self))
        case .houseworkStandard(let housework):
            let addWorkstandardViewModel = AddWorkstandardViewModel(
                coordinator: self,
                housework: housework,
                tagUseCase: diContainer.resolveFetchTagsUseCase(),
                addTagUseCase: diContainer.resolveAddTagUseCase())
            AddWorkstandardView(viewModel: addWorkstandardViewModel)
        case .houseworkMember(let housework):
            AddHouseworkMemberView(viewModel: AddHouseworkMemberViewModel(
                coordinator: self,
                housework: housework,
                fetchMemberUscase: diContainer.resolveFetchMemberUseCase()
            ))
        case .houseworkPlusFinish(let housework):
            AddHouseworkFinishView(viewModel: AddHouseworkFinishViewModel(
                coordinator: self,
                addHouseworkUseCase: diContainer.resolveAddHouseworkUsecase(),
                housework: housework
            ))
        case .houseworkSevendays(let sendEmotion, let receiverName, let houseworkTitle, let receiverImg):
            HouseworkSevendaysView(viewModel: HouseworkSevendaysViewModel(
                coordinator: self,
                fetchDaysUscase: diContainer.resolveFetchDaysUseCase(),
                sendEmotion: sendEmotion,
                receiverName: receiverName,
                houseworTitle: houseworkTitle,
                receiverImg: receiverImg
            ))
        default:
            EmptyView()
        }
    }
    
    @MainActor
    @ViewBuilder
    private func buildEmotionScene(_ scene: AppScene) -> some View {
        switch scene {
        case .emotion:
            let viewModel = EmotionViewModel(
                coordinator: self,
                fetchMemberUseCase: diContainer.resolveFetchMemberUseCase(),
                getEmotionListUscase: diContainer.resolveGetEmotionListUseCase(),
                emotionDetailUseCase: diContainer.resolveDetailEmotionUseCase()
            )
            EmotionView(viewModel: viewModel)
        case .emotionMember(let housework):
            let emotionMemberViewModel = EmotionSendMemberViewModel(
                coordinator: self,
                fetchMemberUscase: diContainer.resolveFetchMemberUseCase(), housework: housework)
            EmotionSendMemberView(viewModel: emotionMemberViewModel)
        case .emotionChoice(let sendEmotion, let receiverName, let houseworkTitle, let receiverImg):
            EmotionChoiceView(viewModel: EmotionChoiceViewModel(
                coordinator: self,
                sendEmotion: sendEmotion,
                receiverName: receiverName,
                houseworkTitle: houseworkTitle,
                receiverImg: receiverImg
            ))
        case .emotionThankMessage(let sendEmotion, let receiverName, let houseworkTitle, let initialEmotion, let receiverImg):
            EmotionThankMessageView(viewModel: EmotionThankMessageViewModel(
                coordinator: self,
                sendEmotion: sendEmotion,
                receiverName: receiverName,
                houseworkTitle: houseworkTitle,
                initialEmotion: initialEmotion,
                receiverImg: receiverImg
            ))
        case .emotionRegretMessage(let sendEmotion, let receiverName, let houseworkTitle, let receiverImg):
            EmotionRegretMessageView(viewModel: EmotionRegretMessageViewModel(
                coordinator: self,
                aiUseCase: diContainer.resolvetransformAiUseCase(),
                sendEmotion: sendEmotion,
                receiverName: receiverName,
                houseworkTitle: houseworkTitle,
                receiverImg: receiverImg
            ))
        case .emotionFinish(let sendEmotion, let receiverName, let houseworkTitle):
            EmotionFinishView(viewModel: EmotionFinishViewModel(
                coordinator: self,
                sendEmotionUseCase: diContainer.resolveSendEmotionUseCase(),
                sendEmotion: sendEmotion,
                receiverName: receiverName,
                houseworkTitle: houseworkTitle
            ))
        case .emotionDetails(let detailEmotion, let isReceived):
            EmotionDetailView(viewModel: EmotionDetailViewModel(
                coordinator: self,
                emotionDetailUseCase: diContainer.resolveDetailEmotionUseCase(),
                emotionDetail: detailEmotion,
                isReceived: isReceived,
                emotionDeleteUseCase: diContainer.resolveDeleteEmotionUseCase()
            ))
        default:
            EmptyView()
        }
    }
    
    @MainActor
    @ViewBuilder
    func buildSheet(_ sheet: AppSheet) -> some View {
        switch sheet {
        case .houseworkSelection(let worklistClickAction):
            HouseworkSelectionSheet(worklistClickAction: worklistClickAction)
        case .placeSelection(let initialPlace, let placeClickAction):
            let viewModel = PlaceSelectionViewModel(
                coordinator: self,
                initialPlace: initialPlace,
                fetchPlacesUseCase: diContainer.resolveFetchPlaceUsecase()
            )
            PlaceSelectionSheet(coordinator: self, viewModel: viewModel, placeClickAction: placeClickAction)
                .presentationDetents([.height(624)])
        case .routineSelection(let initialRoutine, let completeButtonAction):
            RoutinesetSheet(initialRoutine: initialRoutine, completeButtonAction: completeButtonAction)
                .presentationDetents([.height(624)])
        case .calendarSelection(let dateClickAction):
            CalendarDateSheet(dateClickAction: dateClickAction)
                .presentationDetents([.height(624)])
        }
    }
    
    @MainActor
    @ViewBuilder
    func buildFullScreenCover(_ fullScreenCover: AppFullScreenCover) -> some View {
        switch fullScreenCover {
        case .addHousePlace:
            let addPlaceUseCase = diContainer.resolveAddPlaceUseCase()
            let viewModel = AddPlaceViewModel(coordinator: self, usecase: addPlaceUseCase)
            AddPlaceView(viewModel: viewModel)
        }
    }
}
