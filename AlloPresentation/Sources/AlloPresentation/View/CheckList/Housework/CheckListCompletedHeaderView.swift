//
//  CheckListCompletedHeaderView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/9/25.
//

import SwiftUI

struct CheckListCompletedHeaderView: View {
    let count: Int
    let isOpened: Bool
    let onTap: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Button(
                action: {
                    onTap()
                }, label: {
                    HStack(
                        alignment: .center,
                        spacing: 4
                    ) {
                        Text("완료한 집안일")
                            .font(.body1)
                            .foregroundStyle(.gray900)
                        Text("\(count)")
                            .font(.body1)
                            .foregroundStyle(.blue400)
                        Image(isOpened ? .iconChevronUp : .iconChevronDown)
                            .frame(maxWidth: 44, maxHeight: 44)
                    }
                    .frame(height: 44)
                }
            )
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}
