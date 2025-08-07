//
//  TabBarView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: TabBarItem = .home
    @EnvironmentObject var appCoordinator: AppCoordinator

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                switch selectedTab {
                case .home:
                    DIContainer.shared.buildHomeView(appCoordinator: appCoordinator)
                        .environmentObject(appCoordinator)
                case .checklist:
                    DIContainer.shared.buildCheckListView(appCoordinator: appCoordinator)
                        .environmentObject(appCoordinator)
                case .emotion:
                    DIContainer.shared.buildEmotionView(appCoordinator: appCoordinator)
                        .environmentObject(appCoordinator)
                case .mypage:
                    DIContainer.shared.buildMypageView(appCoordinator: appCoordinator)
                        .environmentObject(appCoordinator)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
