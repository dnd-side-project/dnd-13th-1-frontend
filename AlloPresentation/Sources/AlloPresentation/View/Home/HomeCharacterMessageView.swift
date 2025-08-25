//
//  HomeCharacterMessageView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/25/25.
//

import SwiftUI

struct HomeCharacterMessageView: View {
    let message: String
    let onTapMessage: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(spacing: 0) {
                Text(message)
                    .multilineTextAlignment(.center)
                    .font(.subtitle7)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 32)
                Image(.iconChevronRight)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(.gray400)
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 14)
            }
            .background(.gray800)
            .cornerRadius(.radius2)
            Triangle()
                .foregroundStyle(.gray800)
                .frame(width: 10, height: 8)
        }
        .frame(width: 264)
        .onTapGesture {
            onTapMessage()
        }
    }
}
