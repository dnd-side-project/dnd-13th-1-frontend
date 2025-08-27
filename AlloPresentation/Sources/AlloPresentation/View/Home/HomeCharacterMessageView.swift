//
//  HomeCharacterMessageView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/25/25.
//

import SwiftUI

struct HomeCharacterMessageView: View {
    let message: String
    let onTapMessage: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(message)
                .font(.subtitle7)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 72)
                .background(Color.gray800.opacity(0.7))
                .cornerRadius(.radius3)
            ReversedTriangle()
                .foregroundStyle(.gray800)
                .opacity(0.7)
                .frame(width: 10, height: 6)
        }
        .frame(width: 264, height: 78)
        .onTapGesture {
            onTapMessage()
        }
    }
}

struct ReversedTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))   // 왼쪽 위
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // 오른쪽 위
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY)) // 아래 가운데
            path.closeSubpath()
        }
    }
}
