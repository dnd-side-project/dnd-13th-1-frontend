//
//  TitleNavigationBar.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/12/25.
//

import SwiftUI

struct TitleNavigationBar: View {
    let title: String
    let onBack: () -> Void
    var body: some View {
        ZStack(alignment: .center) {
            HStack {
                Button {
                    onBack()
                } label: {
                    Image(.iconNaviBack)
                        .frame(maxWidth: 28, maxHeight: 28)
                }
                Spacer()
            }
            Text(title)
                .font(.subtitle1)
                .foregroundColor(.gray900)
        }
        .frame(height: 54)
    }
}
