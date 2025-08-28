//
//  HomeCharacterView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/25/25.
//

import SwiftUI

struct HomeCharacterView: View {
    let onTapMessage: () -> Void
    let characterStatus: CharacterStatus
    let onTapInfo: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HomeCharacterMessageView(
                message: characterStatus.characterMessage,
                onTapMessage: onTapMessage
            )
            Image(characterStatus.characterImage)
                .resizable()
                .frame(height: 260)
                .aspectRatio(contentMode: .fill)
            HomeCharacterStatusBarView(
                description: characterStatus.description,
                color: characterStatus.backgroundColor,
                onTapInfo: onTapInfo
            )
            .padding(.horizontal, 20)
        }
    }
}

enum CharacterStatus {
    case bored // 일이 없는 경우
    case dirty // 청결도 0 ~ 39%
    case littleClean // 청결도 40 ~ 79%
    case veryClean // 청결도 80 ~ 100%
    
    var backgroundColor: Color {
        switch self {
        case .bored:
            return .gray700
        case .dirty:
            return .red400
        case .littleClean:
            return .blue400
        case .veryClean:
            return .blue500
        }
    }
    
    var description: String {
        switch self {
        case .bored:
            return "심심한 상태에요"
        case .dirty:
            return "많이 꾀죄죄해요"
        case .littleClean:
            return "조금 깔끔해졌어요"
        case .veryClean:
            return "반짝반짝 깨끗해요"
        }
    }
    
    var characterImage: ImageResource {
        switch self {
        case .bored:
            return .illustrationCatNone
        case .dirty:
            return .illustrationCatFirst
        case .littleClean:
            return .illustrationCatSecond
        case .veryClean:
            return .illustrationCatThird
        }
    }
    
    var characterMessage: String {
        switch self {
        case .bored:
            "어서와~ 집안일을 등록해봐!"
        case .dirty:
            "먼지가 나랑 친구하자고 하겠어!"
        case .littleClean:
            "슬슬 할일을 해야할 시간이야!"
        case .veryClean:
            "우와~ 반짝반짝 파티네!"
        }
    }
}
