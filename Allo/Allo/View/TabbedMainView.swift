//
//  TabbedMainView.swift
//  Allo
//
//  Created by Refactor Bot on 8/27/25.
//

import SwiftUI
import Observation
import AlloPresentation

struct TabbedMainView: View {
    @Bindable var appCoordinator: AppCoordinator
    @Binding var selectedTab: TabBarItem

    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            ZStack(alignment: .bottom) {
                Group {
                    switch selectedTab {
                    case .home:
                        appCoordinator.buildScene(.home($selectedTab))
                    case .checklist:
                        appCoordinator.buildScene(.checklist)
                            .ignoresSafeArea(edges: .bottom)
                    case .emotion:
                        appCoordinator.buildScene(.emotion)
                            .ignoresSafeArea(edges: .bottom)
                    case .mypage:
                        appCoordinator.buildScene(.mypage)
                            .ignoresSafeArea(edges: .bottom)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

                TabBarView(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationDestination(for: AppScene.self) { scene in
                appCoordinator.buildScene(scene)
            }
            .sheet(item: $appCoordinator.appSheet, onDismiss: appCoordinator.sheetOnDismiss) {
                appCoordinator.buildSheet($0)
            }
            .fullScreenCover(item: $appCoordinator.appFullScreenCover, onDismiss: appCoordinator.fullScreenCoverOnDismiss) {
                appCoordinator.buildFullScreenCover($0)
            }
            .navigationBarHidden(true)
        }
    }
}
