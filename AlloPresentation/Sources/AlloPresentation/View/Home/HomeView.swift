//
//  HomeView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import Foundation
import SwiftUI
import AlloDomain

public struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @Binding var selectedTab: TabBarItem
    
    public init(viewModel: HomeViewModel, selectedTab: Binding<TabBarItem>) {
        Fonts.registerCustomFonts()
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._selectedTab = selectedTab
    }
    
    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                if viewModel.isLoading {
                    ProgressView()
                        .clipped()
                        .ignoresSafeArea(edges: .top)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding(.bottom, 184 + 20 + 48 + 34)
                } else {
                    Image(viewModel.state.groupType.image)
                        .resizable()
                        .frame(maxWidth: geo.size.width)
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .ignoresSafeArea(edges: .top)
                }
                VStack {
                    HomeNavigationBar(
                        onTapGroup: {
                            viewModel.action(.didTapMemberButton)
                        },
                        onTapNotification: {
                            viewModel.action(.didTapNotificationButton)
                        }
                    )
                    Spacer(minLength: 0)
                    if !viewModel.isLoading {
                        HomeCharacterView(
                            onTapMessage: {
                                viewModel.action(.didTapCharacterMessage)
                            },
                            characterStatus: viewModel.state.characterStatus,
                            onTapInfo: {
                                viewModel.action(.didTapCharacterStatusBar)
                            }
                        )
                        .padding(.bottom, 184 + 20 + 48 + 34)
                    }
                }
                .frame(maxWidth: .infinity)
                .sheet(
                    isPresented: $viewModel.state.isBottomSheetPresented,
                    content: {
                        HomeBottomSheetView(
                            completed: viewModel.state.completedHouseworks,
                            total: viewModel.state.totalHouseworks,
                            cleanliness: viewModel.state.cleanliness,
                            recentHouseworks: viewModel.state.recentHouseworks,
                            onTapEmotionCardList: {
                                viewModel.action(.didTapEmotionCardList)
                            },
                            onTapSendEmotion: { housework in
                                viewModel.action(.didTapSendEmotion(housework))
                            },
                            houseworkPlaces: viewModel.state.houseworkPlaces,
                            onTapAddHousework: {
                                viewModel.action(.didTapAddHousework)
                            },
                            selectedTab: $selectedTab
                        )
                        .presentationDetents([.height(184 + 48), .large])
                        .presentationDragIndicator(.visible)
                        .interactiveDismissDisabled()
                        .presentationCornerRadius(20)
                    }
                )
                .fullScreenCover(
                    isPresented: $viewModel.state.isCharacterStatusSheetPresented,
                    content: {
                        HomeCleanlinessGuideModalView()
                            .ignoresSafeArea()
                            .transaction { $0.animation = .easeInOut }
                    }
                )
            }
        }
    }
}

extension GroupType {
    var image: ImageResource {
        switch self {
        case .roommate:
            return .illustrationBackgroundRoommate
        case .lover:
            return .illustrationBackgroundLover
        case .family:
            return .illustrationBackgroundFamily
        }
    }
}
