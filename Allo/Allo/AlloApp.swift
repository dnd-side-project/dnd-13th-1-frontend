//
//  AlloApp.swift
//  Allo
//
//  Created by 황채웅 on 8/2/25.
//

import SwiftUI
import AlloPresentation
import AlloDomain

@main
struct AlloApp: App {
    @State private var appCoordinator: AppCoordinator
    @State private var selectedTab: TabBarItem = .home
    private let diContainer: DIContainerImpl
    
    init() {
        Fonts.registerCustomFonts()
        self.diContainer = DIContainerImpl()
        let coordinator = AppCoordinator(diContainer: diContainer)
        _appCoordinator = State(initialValue: coordinator)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.path) {
                VStack(spacing: 0) {
                    Group {
                        switch selectedTab {
                        case .home:
                            appCoordinator.buildScene(.home)
                        case .checklist:
                            appCoordinator.buildScene(.checklist)
                        case .emotion:
                            appCoordinator.buildScene(.emotion)
                        case .mypage:
                            appCoordinator.buildScene(.mypage)
                        }
                    }
                    // MARK: - 탭바
                    TabBarView(selectedTab: $selectedTab)
                }
                .navigationDestination(for: AppScene.self) { scene in
                    appCoordinator.buildScene(scene)
                }
            }
        }
    }
}
