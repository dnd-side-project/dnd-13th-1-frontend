//
//  LoginView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/17/25.
//

import SwiftUI

public struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    
    public init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            Spacer()
            Button {
                viewModel.action(.kakaoLoginButtonTapped)
            } label: {
                Image(.iconKakaoLoginLargeWide)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 20)
                    .padding(.vertical, 60)
            }
        }
        .background(.white)
    }
}
