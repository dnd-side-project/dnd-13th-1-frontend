//
//  CornerRadius.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/4/25.
//

import SwiftUI

/// Corner Radius를 구현한 View 익스텐션입니다.
/// - Note: `cornerRadius(_:antialiased:)`는 iOS 13.0에서 deprecated되었으므로, clipShape(_:style:)를 이용합니다.
extension View {
    func cornerRadius(_ style: CornerRadiusStyle, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(RoundedCorner(radius: style.rawValue, corners: corners))
    }
}

/// Allo Design System에 따라 구현한 CornerRadiusStyle입니다.
enum CornerRadiusStyle: CGFloat {
    case radius1 = 8 // 작은 컴포넌트 요소
    case radius2 = 12 // 기본 컴포넌트 요소
    case radius3 = 20 // 컨테이너 카드
}

/// UIBezierPath로 각 모서리를 구현한 구조체입니다.
struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
