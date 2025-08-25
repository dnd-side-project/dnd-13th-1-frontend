//
//  HomeSendEmotionCardView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/25/25.
//

import SwiftUI
import AlloDomain

struct HomeSendEmotionCardView: View {
    
    let houseworks: [Housework]
    let onTapEmotionCardList: () -> Void
    let onTapSendEmotion: (Housework) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text("멤버가 완료한 집안일에\n마음을 전해볼까요?")
                    .multilineTextAlignment(.leading)
                    .font(.headline4)
                    .foregroundStyle(.gray900)
                Spacer(minLength: 0)
                Button(
                    action: {
                        onTapEmotionCardList()
                    }, label: {
                        Text("목록보기")
                            .font(.subtitle3)
                            .foregroundStyle(.gray500)
                    }
                )
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .padding(.bottom, 21)
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(houseworks) { housework in
                        HomeSendEmotionCardCell(housework: housework, onTapSendEmotion: onTapSendEmotion)
                    }
                }
            }
        }
    }
}
