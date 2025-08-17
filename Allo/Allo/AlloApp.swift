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
    private let diContainer: DIContainerImpl
    
    init() {
        Fonts.registerCustomFonts()
        self.diContainer = DIContainerImpl()
        let coordinator = AppCoordinator(diContainer: diContainer)
        _appCoordinator = State(initialValue: coordinator)
    }
    
    var body: some Scene {
        WindowGroup {
            // AddHouseworkView 직접 호출
            let addHouseworkVM = AddHouseworkViewModel(
                addHouseworkUseCase: diContainer.resolveAddHouseworkUsecase(),
                coordinator: appCoordinator
            )
            NavigationStack(path: $appCoordinator.path) {
                AddHouseworkView(viewModel: addHouseworkVM)
                    .navigationBarHidden(true)
                    .navigationDestination(for: AppScene.self) {
                        appCoordinator.buildScene($0)
                            .navigationBarHidden(true)
                    }
                    .sheet(item: $appCoordinator.appSheet, onDismiss: appCoordinator.sheetOnDismiss) {
                        appCoordinator.buildSheet($0)
                    }
            }

        }
    }
}
