//
//  TabBarItem.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import SwiftUI

enum TabBarItem: CaseIterable {
    case home, checklist, emotion, mypage
    var title: String {
        switch self {
        case .home: return "홈"
        case .checklist: return "체크리스트"
        case .emotion: return "마음"
        case .mypage: return "MY"
        }
    }
    var normalTitleColor: Color {
        return .GRAY_300
    }
    var selectedTitleColor: Color {
        return .GRAY_800
    }
    var normalItem: Image {
        switch self {
        case .home:
            return Image(.icHomeUnselected)
        case .checklist:
            return Image(.icCheckListUnSelected)
        case .emotion:
            return Image(.icEmotionUnselected)
        case .mypage:
            return Image(.icMyPageUnSelected)
        }
    }
    var selectedItem: Image {
        switch self {
        case .home:
            return Image(.icHomeSelected)
        case .checklist:
            return Image(.icCheckListSelected)
        case .emotion:
            return Image(.icEmotionSelected)
        case .mypage:
            return Image(.icMyPageSelected)
        }
    }
    var coordinatorScene: TabBarScene {
        switch self {
        case .home:
            TabBarScene.home
        case .checklist:
            TabBarScene.checklist
        case .emotion:
            TabBarScene.emotion
        case .mypage:
            TabBarScene.mypage
        }
    }
}
