//
//  Coordinator.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import Foundation
import SwiftUI

/// Navigation 화면 전환을 관리하는 객체의 프로토콜입니다.
protocol Coordinator: AnyObject {
    var diContainer: DIContainer { get set }
    var path: NavigationPath { get set }
    var sheet: (any AppRoute)? { get set }
    var fullScreenCover: (any AppRoute)? { get set }
    var sheetOnDismiss: (() -> Void)? { get set }
    var fullScreenCoverOnDismiss: (() -> Void)? { get set }
    func push(_ scene: any AppRoute)
    func pop()
    func popToRoot()
    func popLast(_ count: Int)
    func presentSheet(_ sheet: any AppRoute, onDismiss: (() -> Void)?)
    func dismissSheet()
    func presentFullScreenCover(
        _ fullScreenCover: any AppRoute,
        onDismiss: (() -> Void)?
    )
    func dismissFullScreenCover()
}

// MARK: - 기본 구현 제공
extension Coordinator {
    func push(_ scene: any AppRoute) {
        path.append(scene)
    }

    func pop() {
        if !path.isEmpty { path.removeLast() }
    }
    func popLast(_ count: Int) {
        for _ in 0..<count where !path.isEmpty {
            path.removeLast()
        }
    }

    func popToRoot() {
        if !path.isEmpty { path.removeLast(path.count) }
    }

    func presentSheet(_ sheet: any AppRoute, onDismiss: (() -> Void)? = nil) {
        self.sheet = sheet
        self.sheetOnDismiss = onDismiss
    }

    func dismissSheet() {
        self.sheet = nil
        if let onDismiss = sheetOnDismiss { onDismiss() }
        self.sheetOnDismiss = nil
    }

    func presentFullScreenCover(
        _ fullScreenCover: any AppRoute,
        onDismiss: (() -> Void)? = nil
    ) {
        self.fullScreenCover = fullScreenCover
        self.fullScreenCoverOnDismiss = onDismiss
    }

    func dismissFullScreenCover() {
        self.fullScreenCover = nil
        if let onDismiss = fullScreenCoverOnDismiss { onDismiss() }
        self.fullScreenCoverOnDismiss = nil
    }
}
