//
//  File.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/4/25.
//

import SwiftUICore

enum AlloFontName: String, CaseIterable {
    case bold = "Pretendard-Bold"
    case semibold = "Pretendard-SemiBold"
    case medium = "Pretendard-Medium"
    case regular = "Pretendard-Regular"
}

public enum AlloFontStyle {
    case headline1
    case headline2
    case headline3
    case subtitle1
    case subtitle2
    case subtitle3
    case subtitle4
    case subtitle5
    case body1
    case body2
    case body3
    case body4
    case body5
    case button1
    case button2
    case button3
    case caption1
    case caption2
    case caption3

    var weight: String {
        switch self {
        case .headline1, .headline2,
             .subtitle1, .subtitle3,
             .body1, .body4:
            return "Pretendard-Bold"
        case .headline3, .subtitle2, .subtitle4, .button1, .button2, .caption1:
            return "Pretendard-SemiBold"
        case .subtitle5, .body2, .body5, .button3,
             .caption2, .caption3:
            return ["Pretendard-Medium", "Pretendard-Regular"].contains(where: { $0 == self.weight }) ?
                self.weight : "Pretendard-Medium"
        default:
            return "Pretendard-Regular"
        }
    }

    var size: CGFloat {
        switch self {
        case .headline1:
            return 36
        case .headline2, .headline3:
            return 24
        case .subtitle1:
            return 20
        case .subtitle2, .subtitle3, .subtitle4, .subtitle5:
            return 18
        case .body1, .button1:
            return 16
        case .body2, .body3, .button2, .caption1, .caption2:
            return 14
        case .body4, .body5, .button3, .caption3:
            return 12
        }
    }

    var lineSpacing: CGFloat {
        switch self {
        case .headline1:
            return 50 - 36
        case .headline2, .headline3:
            return 34 - 24
        case .subtitle1:
            return 30 - 20
        case .subtitle2, .subtitle3, .subtitle4, .subtitle5:
            return 28 - 18
        case .body1, .button1:
            return 24 - 16
        case .body2, .body3, .button2, .caption1, .caption2:
            return 24 - 14
        case .body4, .body5, .button3, .caption3:
            return 22 - 12
        }
    }

    var kerning: CGFloat {
        switch self {
        case .headline1, .headline2,
             .subtitle1, .subtitle2, .subtitle3, .subtitle4, .subtitle5,
             .body1, .body2, .body3, .body4, .body5,
             .caption1, .caption2, .caption3:
            return -(size * 0.02)  // -2% 자간
        case .headline3, .button1, .button2, .button3:
            return 0
        }
    }
    var font: Font {
        .custom(weight, size: CGFloat(size))
    }
}

extension Font {
    static let headline1 = AlloFontStyle.headline1.font
    static let headline2 = AlloFontStyle.headline2.font
    static let headline3 = AlloFontStyle.headline2.font
    static let subtitle1 = AlloFontStyle.subtitle1.font
    static let subtitle2 = AlloFontStyle.subtitle2.font
    static let subtitle3 = AlloFontStyle.subtitle3.font
    static let subtitle4 = AlloFontStyle.subtitle4.font
    static let subtitle5 = AlloFontStyle.subtitle5.font

    static let body1 = AlloFontStyle.body1.font
    static let body2 = AlloFontStyle.body2.font
    static let body3 = AlloFontStyle.body3.font
    static let body4 = AlloFontStyle.body4.font
    static let body5 = AlloFontStyle.body5.font

    static let button1 = AlloFontStyle.button1.font
    static let button2 = AlloFontStyle.button2.font
    static let button3 = AlloFontStyle.button3.font

    static let caption1 = AlloFontStyle.caption1.font
    static let caption2 = AlloFontStyle.caption2.font
    static let caption3 = AlloFontStyle.caption3.font
}

extension View {
    func alloFont(_ style: AlloFontStyle) -> some View {
        self
            .font(style.font)
            .lineSpacing(style.lineSpacing)
            .kerning(style.kerning)
    }
}

public struct Fonts {
    public static func registerCustomFonts() {
        AlloFontName.allCases.forEach { font in
            guard let url = Bundle.module.url(forResource: font.rawValue, withExtension: "ttf") else { return }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}
