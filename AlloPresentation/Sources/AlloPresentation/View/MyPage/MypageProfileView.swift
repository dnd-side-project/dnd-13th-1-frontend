//
//  MypageProfileView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI
import Kingfisher

struct MypageProfileView: View {
    let profileImageUrl: URL
    let name: String
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            KFImage(profileImageUrl)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 48))
                .overlay(
                    RoundedRectangle(cornerRadius: 48)
                        .inset(by: 1)
                        .stroke(Color.gray200, lineWidth: 1)
                )
                .padding(.bottom, 12)
            Text(name)
                .font(.subtitle1)
                .foregroundStyle(.black)
        }
    }
}
