//
//  TitleNavigationBar.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/12/25.
//

import SwiftUI

struct TitleNavigationBar: View {
    let title: String
    var body: some View {
        ZStack(alignment: .center) {
            HStack {
                Button {
                } label: {
                    Image(.iconChevronLeft)
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

#Preview {
    TitleNavigationBar(title: "집안일추가")
}
