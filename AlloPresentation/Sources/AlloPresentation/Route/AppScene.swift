//
//  AppScene.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import Foundation
import SwiftUI

public enum AppScene: AppRoute {
    case tabBar
    case home
    case checklist
    case emotion
    case mypage
    public var id: String {
        switch self {
        case .tabBar: return "tabBar"
        case .home: return "home"
        case .checklist: return "checklist"
        case .emotion: return "emotion"
        case .mypage: return "mypage"
        }
    }
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}

public enum AppSheet: AppRoute {
    public var id: String {
        switch self {
        }
    }
}

public enum AppFullScreenCover: AppRoute {
    public var id: String {
        switch self {
        }
    }
}
