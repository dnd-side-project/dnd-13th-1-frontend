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
        VStack(alignment: .center, spacing: 0) {
            TitleNavigationBar(
                title: "",
                onBack: {
                    
                }
            )
            Image(.logoBig)
                .resizable()
                .frame(width: 188, height: 94)
                .padding(.bottom, 11)
                .padding(.top, 81)
            Text("함께하는 마음, 함께하는 집안일, 알로")
                .font(.body3)
                .foregroundStyle(.blue400)
            Spacer()
            Button {
                viewModel.action(.kakaoLoginButtonTapped)
            } label: {
                Image(.iconKakaoLoginLargeWide)
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, 60)
            }
        }
        .background(.white)
        .padding(.horizontal, 20)
    }
}
