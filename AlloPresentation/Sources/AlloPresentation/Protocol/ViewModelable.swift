//
//  ViewModelable.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/6/25.
//

import SwiftUI

@MainActor
protocol ViewModelable: ObservableObject {
    associatedtype Action
    associatedtype State
    var state: State { get }
    func action(_ action: Action)
}
