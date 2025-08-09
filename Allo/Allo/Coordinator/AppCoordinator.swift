//
//  AppCoordinator.swift
//  Allo
//
//  Created by 김민솔 on 8/9/25.
//

import SwiftUI
import Combine
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
            if let selectedTab = selectedTab {
                TabBarView(selectedTab: selectedTab)
            } else {
            }
        case .home:
            let homeViewModel = HomeViewModel(appCoordinator: self)
            HomeView(viewModel: homeViewModel)
        case .checklist:
            let checkListViewModel = CheckListViewModel(appCoordinator: self)
            CheckListView(viewModel: checkListViewModel)
        case .emotion:
            let emotionViewModel = EmotionViewModel(appCoordinator: self)
            EmotionView(viewModel: emotionViewModel)
        case .mypage:
            let mypageViewModel = MyPageViewModel(appCoordinator: self)
            MyPageView(viewModel: mypageViewModel)
        }
    }

    @ViewBuilder
    func buildSheet(_ sheet: AppSheet) -> some View {
    }
    @ViewBuilder
    func buildFullScreenCover(_ fullScreenCover: AppFullScreenCover) -> some View {
    }
}
