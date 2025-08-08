//
//  DIContainer.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import Foundation
import SwiftUI
@MainActor
public final class DIContainer {
    public static let shared = DIContainer()
    private init() {}
}

// MARK: - ViewModel 생성
extension DIContainer {
    func makeHomeViewModel(appCoordinator: AppCoordinator) -> HomeViewModel {
        return HomeViewModel(
            appCoordinator: appCoordinator
        )
    }

    func makeCheckListViewModel(appCoordinator: AppCoordinator) -> CheckListViewModel {
        return CheckListViewModel(
            appCoordinator: appCoordinator
        )
    }

    func makeEmotionViewModel(appCoordinator: AppCoordinator) -> EmotionViewModel {
        return EmotionViewModel(
            appCoordinator: appCoordinator
        )
    }

    func makeMyPageViewModel(appCoordinator: AppCoordinator) -> MyPageViewModel {
        return MyPageViewModel(
            appCoordinator: appCoordinator
        )
    }
}

extension DIContainer {
    func buildTabBarView(appCoordinator: AppCoordinator) -> some View {
        TabBarView()
            .environmentObject(appCoordinator)
    }

    func buildHomeView(appCoordinator: AppCoordinator) -> HomeView {
        return HomeView(
            viewModel: self.makeHomeViewModel(appCoordinator: appCoordinator)
        )
    }

    func buildCheckListView(appCoordinator: AppCoordinator) -> CheckListView {
        return CheckListView(
            viewModel: self.makeCheckListViewModel(appCoordinator: appCoordinator)
        )
    }

    func buildEmotionView(appCoordinator: AppCoordinator) -> EmotionView {
        return EmotionView(
            viewModel: self.makeEmotionViewModel(appCoordinator: appCoordinator)
        )
    }

    func buildMypageView(appCoordinator: AppCoordinator) -> MyPageView {
        return MyPageView(
            viewModel: self.makeMyPageViewModel(appCoordinator: appCoordinator)
        )
    }
}
