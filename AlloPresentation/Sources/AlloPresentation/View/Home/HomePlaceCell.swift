//
//  HomePlaceCell.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/27/25.
//

import SwiftUI

struct HomePlaceCell: View {
    let image: ImageResource
    let place: String
    let count: Int
    var body: some View {
        HStack(spacing: 0) {
            Image(image)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.trailing, 12)
            Text(place)
                .font(.subtitle2)
                .foregroundStyle(.gray900)
            Spacer(minLength: 0)
            if count > 0 {
                Text("\(count) 개")
                    .font(.subtitle6)
                    .foregroundStyle(.gray700)
            } else {
                Text("할 일 없음")
                    .font(.body3)
                    .foregroundStyle(.gray300)
            }
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(.radius2)
    }
}
