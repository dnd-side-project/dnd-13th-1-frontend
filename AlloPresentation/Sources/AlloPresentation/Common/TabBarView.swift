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
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .home:
                DIContainer.shared.buildHomeView(appCoordinator: appCoordinator)
            case .checklist:
                DIContainer.shared.buildCheckListView(appCoordinator: appCoordinator)
            case .emotion:
                DIContainer.shared.buildEmotionView(appCoordinator: appCoordinator)
            case .mypage:
                DIContainer.shared.buildMypageView(appCoordinator: appCoordinator)
            }
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                HStack {
                    ForEach(TabBarItem.allCases, id: \.self) { (item: TabBarItem) in
                        let isSelected = selectedTab == item
                        Button(
                            action: {
                                selectedTab = item
                            },
                            label: {
                                VStack(spacing: 0) {
                                    (isSelected ? item.selectedItem : item.normalItem)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    Text(item.title)
                                        .font(.caption3)
                                        .foregroundColor(
                                            isSelected ? item.selectedTitleColor : item.normalTitleColor
                                        )
                                }
                            }
                        )
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 48)
                .padding(.bottom, 34)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
