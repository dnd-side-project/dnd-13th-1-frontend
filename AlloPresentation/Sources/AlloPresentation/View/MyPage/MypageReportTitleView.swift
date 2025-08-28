//
//  MypageReportTitleView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/28/25.
//

import SwiftUI

struct MypageReportTitleView: View {
    let dateString: String
    let title: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(dateString)
                .font(.body6)
                .foregroundStyle(.gray300)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 4)
            Text(title)
                .coloredNumbersText(title, numberColor: .blue400)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .font(.subtitle3)
                .foregroundStyle(.gray900)
                .frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}
