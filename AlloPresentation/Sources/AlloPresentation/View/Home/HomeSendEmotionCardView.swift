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
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .top) {
                Text("멤버가 완료한 집안일에\n마음을 전해볼까요?")
                    .font(.headline4)
                    .foregroundStyle(.gray900)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer(minLength: 0)
                if houseworks.count == 0 {
                    Button(
                        action: {
                            onTapEmotionCardList()
                        }, label: {
                            Text("+ 추가")
                                .font(.subtitle3)
                                .foregroundStyle(.blue400)
                        }
                    )
                } else {
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
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
            if houseworks.count > 0 {
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(houseworks) { housework in
                            HomeSendEmotionCardCell(housework: housework, onTapSendEmotion: onTapSendEmotion)
                        }
                    }
                }
            } else {
                Text("아직 완수한 집안일이 없어요!\n집안일을 등록하고 완수해보세요.")
                    .font(.subtitle6)
                    .foregroundStyle(.gray300)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 208)
            }
        }
    }
}
