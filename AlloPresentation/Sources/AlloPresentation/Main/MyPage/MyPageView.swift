//
//  MyPageView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import Foundation
import SwiftUI

public struct MyPageView: View {
    @State private var viewModel: MyPageViewModel
    public init(viewModel: MyPageViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }
    public var body: some View {
    }
}
