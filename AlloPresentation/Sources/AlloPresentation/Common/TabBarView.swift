//
//  TabBarView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import SwiftUI

public struct TabBarView: View {
    @Binding var selectedTab: TabBarItem
    public init(selectedTab: Binding<TabBarItem>) {
        self._selectedTab = selectedTab
    }
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(TabBarItem.allCases, id: \.self) { item in
                    Button {
                        selectedTab = item
                    } label: {
                        VStack(spacing: 0) {
                            (selectedTab == item ? item.selectedItem : item.normalItem)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            Text(item.title)
                                .font(.caption3)
                                .foregroundColor(selectedTab == item ? item.selectedTitleColor : item.normalTitleColor)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 48)
            .padding(.bottom, 34)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
