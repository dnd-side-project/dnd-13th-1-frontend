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
    
    /// 특정 단어를 다른 색상으로 표시하는 Text를 생성합니다.
    /// - Parameters:
    ///   - text: 원본 텍스트
    ///   - target: 색상을 변경할 대상 단어
    ///   - color: 대상 단어에 적용할 색상
    ///   - defaultColor: 기본 텍스트 색상 (미사용 시 시스템 기본색)
    ///   - caseInsensitive: 대소문자 무시 여부
    ///   - wholeWord: 완전한 단어 일치 여부 (공백/경계 기준)
    /// - Returns: 대상 단어가 다른 색상으로 표시된 Text
    static func withColoredWord(
        _ text: String,
        target: String,
        color: Color,
        defaultColor: Color = .primary,
        caseInsensitive: Bool = false,
        wholeWord: Bool = false
    ) -> Text {
        guard !target.isEmpty else { return Text(text) }
        let attributedString = NSMutableAttributedString(string: text)
        
        let escaped = NSRegularExpression.escapedPattern(for: target)
        let pattern: String
        if wholeWord {
            // 단어 경계: \b는 영문/숫자 기준이라 한글에는 제한적. 공백/문자열 경계를 보완.
            pattern = "(?:(?<=^)|(?<=\\s))" + escaped + "(?:(?=$)|(?=\\s))"
        } else {
            pattern = escaped
        }
        
        let options: NSRegularExpression.Options = caseInsensitive ? [.caseInsensitive] : []
        let regex = try? NSRegularExpression(pattern: pattern, options: options)
        let range = NSRange(location: 0, length: text.utf16.count)
        
        if let regex = regex {
            let matches = regex.matches(in: text, options: [], range: range)
            for match in matches {
                attributedString.addAttribute(
                    .foregroundColor,
                    value: UIColor(color),
                    range: match.range
                )
            }
        }
        
        return Text(AttributedString(attributedString))
    }
    
    /// 여러 단어를 동일한 색상으로 표시합니다.
    /// - Parameters:
    ///   - text: 원본 텍스트
    ///   - targets: 색상을 변경할 대상 단어 목록
    ///   - color: 대상 단어에 적용할 색상
    ///   - caseInsensitive: 대소문자 무시 여부
    ///   - wholeWord: 완전한 단어 일치 여부
    static func withColoredWords(
        _ text: String,
        targets: [String],
        color: Color,
        caseInsensitive: Bool = false,
        wholeWord: Bool = false
    ) -> Text {
        guard !targets.isEmpty else { return Text(text) }
        var result = Text("")
        // 성능보다는 간결성을 위해 순차 적용
        var working = text
        // NSAttributedString 누적을 위해 하나의 attributedString으로 처리
        let attributedString = NSMutableAttributedString(string: working)
        let fullRange = NSRange(location: 0, length: working.utf16.count)
        
        for target in targets where !target.isEmpty {
            let escaped = NSRegularExpression.escapedPattern(for: target)
            let pattern: String = wholeWord
                ? "(?:(?<=^)|(?<=\\s))" + escaped + "(?:(?=$)|(?=\\s))"
                : escaped
            let options: NSRegularExpression.Options = caseInsensitive ? [.caseInsensitive] : []
            if let regex = try? NSRegularExpression(pattern: pattern, options: options) {
                let matches = regex.matches(in: working, options: [], range: fullRange)
                for match in matches {
                    attributedString.addAttribute(
                        .foregroundColor,
                        value: UIColor(color),
                        range: match.range
                    )
                }
            }
        }
        result = Text(AttributedString(attributedString))
        return result
    }
    
    /// 단어별로 서로 다른 색상을 적용합니다.
    /// - Parameters:
    ///   - text: 원본 텍스트
    ///   - colorMap: [단어: 색상]
    ///   - caseInsensitive: 대소문자 무시 여부
    ///   - wholeWord: 완전한 단어 일치 여부
    static func withColoredWords(
        _ text: String,
        colorMap: [String: Color],
        caseInsensitive: Bool = false,
        wholeWord: Bool = false
    ) -> Text {
        guard !colorMap.isEmpty else { return Text(text) }
        let attributedString = NSMutableAttributedString(string: text)
        let fullRange = NSRange(location: 0, length: text.utf16.count)
        
        for (target, color) in colorMap where !target.isEmpty {
            let escaped = NSRegularExpression.escapedPattern(for: target)
            let pattern: String = wholeWord
                ? "(?:(?<=^)|(?<=\\s))" + escaped + "(?:(?=$)|(?=\\s))"
                : escaped
            let options: NSRegularExpression.Options = caseInsensitive ? [.caseInsensitive] : []
            if let regex = try? NSRegularExpression(pattern: pattern, options: options) {
                let matches = regex.matches(in: text, options: [], range: fullRange)
                for match in matches {
                    attributedString.addAttribute(
                        .foregroundColor,
                        value: UIColor(color),
                        range: match.range
                    )
                }
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
