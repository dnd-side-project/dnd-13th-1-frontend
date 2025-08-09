//
//  DIContainer.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import Foundation
import SwiftUI
@MainActor
public final class DIContainer {
    public static let shared = DIContainer()
    private init() {}
}
