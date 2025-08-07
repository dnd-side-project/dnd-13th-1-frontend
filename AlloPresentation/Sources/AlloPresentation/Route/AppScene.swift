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
    public var id: String {
        switch self {
        case .tabBar: return "tabBar"
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
