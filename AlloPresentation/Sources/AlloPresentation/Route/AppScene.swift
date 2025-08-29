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
    case home(Binding<TabBarItem>)
    case checklist
    case emotion
    case mypage
    case houseworkPlus
    case houseworkStandard(housework: Housework)
    case houseworkMember(housework: Housework)
    case houseworkPlusFinish(housework: Housework)
    case houseworkSevendays(sendEmotion: SendEmotion, receiverName: String, houseworkTitle: String, receiverImg: URL?)
    case emotionChoice(sendEmotion: SendEmotion, receiverName: String, houseworkTitle: String, receiverImg: URL?)
    case emotionThankMessage(sendEmotion: SendEmotion, receiverName: String, houseworkTitle: String, initialEmotion: EmotionType, receiverImg: URL?)
    case emotionRegretMessage(sendEmotion: SendEmotion, receiverName: String, houseworkTitle: String, receiverImg: URL?)
    case emotionMember(housework: Housework)
    case emotionFinish(sendEmotion: SendEmotion, receiverName: String, houseworkTitle: String)
    case emotionDetails(detailEmotion: EmotionDetail, isReceived: Bool)
    public var id: String {
        String(describing: self)
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
    case placeSelection(initialPlace: String, placeClickAction: (String, Int) -> Void)
    case routineSelection(initialRoutine: String, completeButtonAction: (String, [String], String) -> Void)
    case calendarSelection(dateSelectedAction: (String) -> Void)
    case houseworkDetailSelection(housework: Housework, onDismissAction: () -> Void)
    
    public var id: String {
        switch self {
        case .houseworkSelection: return "houseworkSelection"
        case .placeSelection:     return "placeSelection"
        case .routineSelection:   return "routineSelection"
        case .calendarSelection:  return "calendarSelection"
        case .houseworkDetailSelection: return "houseworkDetailSelection"
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
