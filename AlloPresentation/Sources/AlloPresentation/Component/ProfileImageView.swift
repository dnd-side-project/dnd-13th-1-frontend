//
//  ProfileImageView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/29/25.
//

import SwiftUI
import Kingfisher

struct ProfileImageView: View {
    let url: URL?
    let size: CGFloat
    let cornerRadius: CGFloat
    var body: some View {
        Group {
            if let url = url {
                KFImage(url)
                    .resizable()
            } else {
                Image(.illustrationDefaultProfile)
                    .resizable()
            }
        }
        .scaledToFit()
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .inset(by: 1)
                .stroke(.gray200, lineWidth: 1)
        )
    }
}
