//
//  HomeView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import Foundation
import SwiftUI

public struct HomeView: View {
    @State private var viewModel: HomeViewModel
    public init(viewModel: HomeViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }
    public var body: some View {
    }
}
