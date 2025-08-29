//
//  TabBarItem.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import SwiftUI

public enum TabBarItem: CaseIterable {
    case home, checklist, emotion, mypage
    var title: String {
        switch self {
        case .home: return "메뉴"
        case .checklist: return "체크리스트"
        case .emotion: return "마음함"
        case .mypage: return "마이"
        }
    }
    var normalTitleColor: Color {
        return .gray300
    }
    var selectedTitleColor: Color {
        return .gray800
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
