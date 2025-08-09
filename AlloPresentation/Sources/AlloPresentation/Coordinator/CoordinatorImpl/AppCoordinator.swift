//
//  AppCoordinator.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import Foundation
import SwiftUI
import Combine

@Observable
public final class AppCoordinator: Coordinator, ObservableObject {
    var sheetOnDismiss: (() -> Void)?
    var fullScreenCoverOnDismiss: (() -> Void)?
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

    public init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }
    @MainActor @ViewBuilder
    func buildScene(_ scene: AppScene) -> some View {
        switch scene {
        case .tabBar:
            TabBarView().environmentObject(self)
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
    @MainActor
    public var start: some View {
        buildScene(.tabBar)
    }

    @ViewBuilder
    func buildSheet(_ sheet: AppSheet) -> some View {
    }
    @ViewBuilder
    func buildFullScreenCover(_ fullScreenCover: AppFullScreenCover) -> some View {
    }
}
