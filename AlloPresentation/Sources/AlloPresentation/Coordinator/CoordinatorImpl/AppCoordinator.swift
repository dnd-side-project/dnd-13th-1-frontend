//
//  AppCoordinator.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import Foundation
import SwiftUI

@Observable
final class AppCoordinator: Coordinator, ObservableObject {
    var sheetOnDismiss: (() -> Void)?
    var fullScreenCoverOnDismiss: (() -> Void)?
    var diContainer: DIContainer
    var path = NavigationPath()
    var sheet: (any AppRoute)?
    var fullScreenCover: (any AppRoute)?
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }

    @MainActor
    @ViewBuilder
    func buildScene(_ scene: AppScene) -> some View {
        switch scene {
        case .tabBar:
            diContainer.buildTabBarView()
        }
    }

    @ViewBuilder
    func buildSheet(_ sheet: AppSheet) -> some View {
    }
    @ViewBuilder
    func buildFullScreenCover(_ fullScreenCover: AppFullScreenCover) -> some View {
    }
}
