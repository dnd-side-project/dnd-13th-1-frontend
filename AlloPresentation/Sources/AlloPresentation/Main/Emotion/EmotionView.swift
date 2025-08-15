//
//  EmotionView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/7/25.
//

import Foundation
import SwiftUI

public struct EmotionView: View {
    @State private var viewModel: EmotionViewModel
    public init(viewModel: EmotionViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }
    public var body: some View {
        VStack {
            Spacer()
        }
        frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
