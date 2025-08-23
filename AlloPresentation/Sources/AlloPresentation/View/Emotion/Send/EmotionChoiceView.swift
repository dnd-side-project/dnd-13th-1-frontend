//
//  EmotionChoiceView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI
import AlloDomain

public struct EmotionChoiceView: View {
    @StateObject private var viewModel: EmotionChoiceViewModel
    public init(viewModel: EmotionChoiceViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    public var body: some View {
        VStack(alignment: .leading) {
            TitleNavigationBar(title: "", onBack: { viewModel.action(.didTapBackButton)})
            Text("누구에게 보내는 마음인가요?")
                .font(.headline4)
                .foregroundStyle(.gray900)
            Spacer()
            MainButton(
                title: "다음으로",
                action: { viewModel.action(.didTapNextButton)},
                style: .bottoomMain
            )
            .padding(.bottom, 46)
        }.padding(.horizontal, 20)
    }
}
