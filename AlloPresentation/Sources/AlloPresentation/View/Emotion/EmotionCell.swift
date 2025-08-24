//
//  EmotionCell.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/23/25.
//

import SwiftUI
import AlloDomain

struct EmotionCell: View {
    let emotion: EmotionList

    private func icon(for type: String) -> Image {
        switch type {
        case "thank":
            return Image(.iconThank)
        case "regretful":
            return Image(.iconRegret)
        case "both":
            return Image(.iconBoth)
        default:
            return Image(.iconThank)
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            icon(for: emotion.emotionType)
                .padding(.leading, 20)

            VStack(alignment: .leading, spacing: 4) {
                Text(emotion.houseWorkName)
                    .font(.caption2)
                    .foregroundStyle(.gray500)

                Text(emotion.content)
                    .font(.subtitle7)
                    .foregroundStyle(.gray800)
                    .lineLimit(1)

                Text("From. \(emotion.senderNickName)")
                    .font(.button3)
                    .foregroundColor(.gray500)
            }

            Spacer()

            Text(dateString(from: emotion.createdTime))
                .font(.caption3)
                .foregroundColor(.gray300)
                .padding(.trailing, 20)
        }
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray25)
        )
    }

    private func dateString(from date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        let startOfToday = calendar.startOfDay(for: now)
        let startOfTargetDay = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: startOfTargetDay, to: startOfToday)
        let dayDiff = components.day ?? 0

        switch dayDiff {
        case 0:
            return "오늘"
        case 1:
            return "어제"
        default:
            return "\(dayDiff)일 전"
        }
    }
}
