//
//  HomeCharacterStatusBarView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/25/25.
//

import SwiftUI

struct HomeCharacterStatusBarView: View {
    let description: String
    let color: Color
    let onTapInfo: () -> Void
    
    var body: some View {
        HStack {
            Button(
                action: {
                    onTapInfo()
                }, label: {
                    HStack(spacing: 4) {
                        Text("캐릭터 상태")
                            .font(.subtitle6)
                            .foregroundStyle(.white)
                        Image(.iconInfo)
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    .frame(height: 26)
                }
            )
            Spacer()
            Text(description)
                .font(.subtitle2)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 18)
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .background(color)
        .cornerRadius(.radius2)
    }
}
