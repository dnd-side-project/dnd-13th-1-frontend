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
    case houseworkPlus
    case houseworkStandard(myHouseworkTitle: String)
    case houseworkMember(myHouseworkTitle: String, tagList: [String])
    case houseworkPlusFinish(data: HouseworkFinishData)
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
    case placeSelection(placeClickAction: (String) -> Void)
    case routineSelection(completeButtonAction: (String) -> Void)
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
    public var id: String {
        switch self {
        }
    }
}

public struct HouseworkFinishData {
    public let myHouseworkTitle: String
    public let place: String
    public let routine: String
    public let deadline: String
    public let tagList: [String]

    public init(myHouseworkTitle: String, place: String, routine: String, deadline: String, tagList: [String]) {
        self.myHouseworkTitle = myHouseworkTitle
        self.place = place
        self.routine = routine
        self.deadline = deadline
        self.tagList = tagList
    }
}
