import SwiftUI

extension Text {
    /// 숫자만 다른 색상으로 표시하는 Text를 생성합니다.
    /// - Parameters:
    ///   - text: 원본 텍스트
    ///   - numberColor: 숫자에 적용할 색상
    ///   - defaultColor: 기본 텍스트 색상
    /// - Returns: 숫자가 다른 색상으로 표시된 Text
    static func withColoredNumbers(
        _ text: String,
        numberColor: Color,
        defaultColor: Color = .primary
    ) -> Text {
        let attributedString = NSMutableAttributedString(string: text)
        
        // 정규식을 사용하여 숫자 찾기
        let pattern = "\\d+"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        
        if let regex = regex {
            let range = NSRange(location: 0, length: text.utf16.count)
            let matches = regex.matches(in: text, options: [], range: range)
            
            for match in matches {
                attributedString.addAttribute(
                    .foregroundColor,
                    value: UIColor(numberColor),
                    range: match.range
                )
            }
        }
        
        return Text(AttributedString(attributedString))
    }
    
    /// 숫자만 다른 색상으로 표시하는 Text를 생성합니다 (기본 색상 사용).
    /// - Parameters:
    ///   - text: 원본 텍스트
    ///   - numberColor: 숫자에 적용할 색상
    /// - Returns: 숫자가 다른 색상으로 표시된 Text
    static func withColoredNumbers(
        _ text: String,
        numberColor: Color
    ) -> Text {
        return withColoredNumbers(text, numberColor: numberColor, defaultColor: .primary)
    }
}

// MARK: - View Extension
extension View {
    /// 숫자만 다른 색상으로 표시하는 Text를 생성하는 편의 메서드입니다.
    /// - Parameters:
    ///   - text: 원본 텍스트
    ///   - numberColor: 숫자에 적용할 색상
    ///   - defaultColor: 기본 텍스트 색상
    /// - Returns: 숫자가 다른 색상으로 표시된 Text
    func coloredNumbersText(
        _ text: String,
        numberColor: Color,
        defaultColor: Color = .primary
    ) -> Text {
        return Text.withColoredNumbers(text, numberColor: numberColor, defaultColor: defaultColor)
    }
}
