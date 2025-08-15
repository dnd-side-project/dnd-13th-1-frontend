//
//  TabBarScene.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import SwiftUI

enum TabBarScene: AppRoute {
    case home
    case checklist
    case emotion
    case mypage
    var id: String {
        switch self {
        case .home:
            return "home"
        case .checklist:
            return "checklist"
        case .emotion:
            return "emotion"
        case .mypage:
            return "mypage"
        }
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}

enum TabBarSheet: AppRoute {
    case none
    var id: String {
        switch self {
        case .none:
            return "none"
        }
    }
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}

enum TabBarFullScreenCover: AppRoute {
    case none
    var id: String {
        switch self {
        case .none:
            return "none"
        }
    }
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}
