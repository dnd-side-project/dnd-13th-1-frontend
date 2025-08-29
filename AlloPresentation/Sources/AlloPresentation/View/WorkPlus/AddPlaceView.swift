//
//  AddPlaceView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/16/25.
//

import SwiftUI

public struct AddPlaceView: View {
    @StateObject private var viewModel: AddPlaceViewModel
    @State private var newPlaceText: String = ""
    public init(viewModel: AddPlaceViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    public var body: some View {
        VStack(alignment: .leading) {
            TitleNavigationBar(title: "", onBack: {viewModel.action(.didTapBackButton)})
                .padding(.bottom, 50)
            Text("추가할 장소를 작성해주세요!")
                .font(.headline4)
                .foregroundColor(.gray900)
            Text("장소는 최대 10개까지 생성할 수 있어요.")
                .font(.body4)
                .foregroundStyle(.gray600)
            UnderlineTextField(text: $viewModel.state.newPlaceName)
                .padding(.top, 28)
            Spacer()
            MainButton(
                title: "새로운 장소 추가하기",
                action: { viewModel.action(.didTapAddPlaceButton) },
                style: .bottoomMain
            )
            .padding(.bottom, 16)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .padding(.horizontal, 20)

    }

}
struct UnderlineTextField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    var placeholder: String = ""
    var maxLength: Int = 20
    var body: some View {
        VStack(spacing: 4) {
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .textFieldStyle(PlainTextFieldStyle())
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.gray400)
                .animation(.easeInOut(duration: 0.2), value: isFocused)
        }
    }
}
