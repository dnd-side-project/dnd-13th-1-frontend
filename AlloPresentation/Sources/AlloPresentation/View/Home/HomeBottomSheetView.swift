//
//  HomeBottomSheetView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/25/25.
//

import SwiftUI
import AlloDomain

struct HomeBottomSheetView: View {
    let completed: Int
    let total: Int
    let cleanliness: Int
    let recentHouseworks: [Housework]
    let onTapEmotionCardList: () -> Void
    let onTapSendEmotion: (Housework) -> Void
    let houseworkPlaces: [String : [Housework]]
    let onTapAddHousework: () -> Void
    @Binding var selectedTab: TabBarItem
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 0) {
                    HomeReportView(
                        completed: completed,
                        total: total,
                        cleanliness: cleanliness
                    )
                    .padding(.top, 36)
                    .padding(.bottom, 70)
                    HomeSendEmotionCardView(
                        houseworks: recentHouseworks,
                        onTapEmotionCardList: onTapEmotionCardList,
                        onTapSendEmotion: onTapSendEmotion
                    )
                    .padding(.bottom, 70)
                    HomeTodayPlaceHouseworkView(
                        houseworkPlaces: houseworkPlaces,
                        onTapAddHousework: onTapAddHousework
                    )
                    .padding(.bottom, 70)
                }
                .frame(maxWidth: .infinity, alignment: .top)
            }
            .scrollIndicators(.hidden)
            .background(.gray25)
            TabBarView(selectedTab: $selectedTab)
        }.ignoresSafeArea(edges: .bottom)
    }
}
