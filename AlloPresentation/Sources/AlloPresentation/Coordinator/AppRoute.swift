//
//  AppRoute.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import Foundation

public protocol AppRoute: Hashable, Identifiable {
    var id: String { get }
}
