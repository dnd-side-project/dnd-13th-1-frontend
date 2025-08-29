//
//  HomeSendEmotionCardCell.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/25/25.
//

import SwiftUI
import AlloDomain
import Kingfisher

struct HomeSendEmotionCardCell: View {
    let housework: Housework
    let onTapSendEmotion: (Housework) -> Void
    
    init(housework: Housework, onTapSendEmotion: @escaping (Housework) -> Void) {
        self.housework = housework
        self.onTapSendEmotion = onTapSendEmotion
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Text(housework.place)
                    .font(.button3)
                    .foregroundStyle(.blue400)
                    .padding(.horizontal, 8)
                    .frame(height: 20)
                    .background(.blue50)
                    .cornerRadius(.radius3)
                    .padding(.trailing, 6)
                Text(housework.title)
                    .font(.subtitle6)
                    .foregroundStyle(.gray700)
                    .padding(.bottom, 8)
                Spacer(minLength: 0)
            }
            HStack(spacing: -19) {
                ForEach(housework.member) { member in
                    ProfileImageView(
                        url: member.profileImageUrl,
                        size: 44,
                        cornerRadius: 20
                    )
                }
                Spacer(minLength: 0)
            }
            Text(formatDateToString(housework.date))
                .font(.body3)
                .opacity(0.5)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                .padding(.bottom, 8)
            Button(
                action: {
                    onTapSendEmotion(housework)
                }, label: {
                    HStack(spacing: 0) {
                        Image(.iconSend)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 10)
                        Text("마음 보내기")
                            .font(.subtitle6)
                            .foregroundStyle(.white)
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 37)
                    .padding(.vertical, 16)
                    .background(.blue400)
                    .frame(width: 178, height: 58)
                    .cornerRadius(.radius2) // FIXME: 디자인 시스템대로 수정
                }
            )
            .frame(maxWidth: .infinity)
        }
        .padding(.all, 16)
        .frame(width: 210, height: 206)
        .background(.white)
        .cornerRadius(.radius2)
    }
}

extension HomeSendEmotionCardCell {
    func formatDateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}

//#Preview {
//    HomeSendEmotionCardCell(housework: Housework(id: 11, place: "Ddd", title: "dddd", member: [Member(id: 1, name: "ddd", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!)], date: Date(), isDone: false, routine: HouseworkRoutine.none, tags: ["dd"])) { housework in
//        
//    }
//}
