//
//  AppScene.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import Foundation
import SwiftUI
import AlloDomain

public enum AppScene: AppRoute {
    case tabBar
    case home
    case checklist
    case emotion
    case mypage
    case houseworkPlus
    case houseworkStandard(housework: Housework)
    case houseworkMember(housework: Housework)
    case houseworkPlusFinish(housework: Housework)
    public var id: String {
        switch self {
        case .tabBar: return "tabBar"
        case .home: return "home"
        case .checklist: return "checklist"
        case .emotion: return "emotion"
        case .mypage: return "mypage"
        case .houseworkPlus: return "houseworkPlus"
        case .houseworkStandard: return "houseworkStandard"
        case .houseworkMember: return "houseworkMember"
        case .houseworkPlusFinish: return "houseworkPlusFinish"
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
    case houseworkSelection(worklistClickAction: (String) -> Void)
    case placeSelection(initialPlace: String, placeClickAction: (String) -> Void)
    case routineSelection(initialRoutine: String, completeButtonAction: (String) -> Void)
    case calendarSelection(dateSelectedAction: (String) -> Void)
    
    public var id: String {
        switch self {
        case .houseworkSelection: return "houseworkSelection"
        case .placeSelection:     return "placeSelection"
        case .routineSelection:   return "routineSelection"
        case .calendarSelection:  return "calendarSelection"
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}

public enum AppFullScreenCover: AppRoute {
    case addHousePlace
    
    public var id: String {
        switch self {
        case .addHousePlace: return "addHousePlace"
        }
    }
    
    public static func == (lhs: AppFullScreenCover, rhs: AppFullScreenCover) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
