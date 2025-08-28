//
//  MypageNavigationBar.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI

struct MypageNavigationBar: View {
    
    let onTapBackButton: (() -> Void)?
    let onTapSettings: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 0) {
            if let onTapBackButton {
                Button(
                    action: {
                        onTapBackButton()
                    }, label: {
                        Image(.iconChevronLeft)
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                )
            } else {
                EmptyView()
                    .frame(width: 32, height: 32)
            }
            Spacer(minLength: 0)
            Text("마이페이지")
                .font(.subtitle1)
                .foregroundStyle(.gray900)
            Spacer(minLength: 0)
            if let onTapSettings {
                Button(
                    action: {
                        onTapSettings()
                    }, label: {
                        Image(.iconSetting)
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                )
            } else {
                EmptyView()
                    .frame(width: 32, height: 32)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
    }
}
