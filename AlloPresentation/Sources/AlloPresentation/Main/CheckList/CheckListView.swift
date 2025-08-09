//
//  CheckListView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import Foundation
import SwiftUI

public struct CheckListView: View {
    @State private var viewModel: CheckListViewModel
    public init(viewModel: CheckListViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }
    public var body: some View {
    }
}
