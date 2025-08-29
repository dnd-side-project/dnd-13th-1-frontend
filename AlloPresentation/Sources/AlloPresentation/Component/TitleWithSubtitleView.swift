//
//  TitleWithSubtitleView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI

struct TitleWithSubtitleView: View {
    let title: String
    let subtitle: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .lineLimit(.none)
                .font(.headline4)
                .foregroundStyle(.gray900)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(subtitle)
                .lineLimit(.none)
                .font(.body4)
                .foregroundStyle(.gray600)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
