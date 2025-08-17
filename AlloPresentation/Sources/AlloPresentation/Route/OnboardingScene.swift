//
//  OnboardingScene.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/17/25.
//

import Foundation
import SwiftUI

public enum OnboardingScene: AppRoute {
    case login
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

public enum OnboardingSheet: AppRoute {
    public var id: String {
        switch self {
        }
    }
}

public enum OnboardingFullScreenCover: AppRoute {
    public var id: String {
        switch self {
        }
    }
}
