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

struct CharacterStatus {
    let cleanliness: Int
    let state: String
    let message: String
    
    var backgroundColor: Color {
        if cleanliness >= 80 {
            return .blue500
        } else if cleanliness >= 40 {
            return .blue400
        } else if cleanliness > 0 {
            return .red400
        } else {
            return .gray700
        }
    }
    
    var description: String {
        return state
    }
    
    var characterImage: ImageResource {
        if cleanliness >= 80 {
            return .illustrationCatThird
        } else if cleanliness >= 40 {
            return .illustrationCatSecond
        } else if cleanliness > 0 {
            return .illustrationCatFirst
        } else {
            return .illustrationCatNone
        }
    }
    
    var characterMessage: String {
        return message
    }
}
