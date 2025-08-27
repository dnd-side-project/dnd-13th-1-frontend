//
//  MyPageView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import Foundation
import SwiftUI

public struct MyPageView: View {
    @StateObject private var viewModel: MyPageViewModel
    public init(viewModel: MyPageViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    public var body: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
