//
//  AddHouseworkFinishView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/17/25.
//

import SwiftUI
import Kingfisher
import AlloDomain

public struct AddHouseworkFinishView: View {
    let member: Member = Member(
        id: 0,
        name: "기본멤버",
        profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/0.jpg")!
    )
    @State private var viewModel: AddHouseworkFinishViewModel
    public init(viewModel: AddHouseworkFinishViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }
    private let members: [Member] = [
        Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),
        Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/51.jpg")!),
        Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/52.jpg")!)
    ]

    private let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    public var body: some View {
        VStack(spacing: 0) {
            TitleNavigationBar(title: "", onBack: {viewModel.action(.didTapBackButton)})
            Spacer()
            VStack(spacing: 0) {
                VStack(alignment: .center) {
                    OverlappingProfileImages(members: [
                        Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),
                        Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/51.jpg")!)
                    ])
                    Spacer()
                    Text("집안일을 분담할 멤버에게\n알림을 보낼게요!")
                        .font(.headline4)
                        .foregroundColor(.gray900)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 164)
                .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text(viewModel.state.housework.title)
                            .font(.subtitle1)
                            .foregroundColor(.gray800)
                            .padding(.bottom, 12)
                        HStack {
                            Text("장소")
                                .font(.subtitle6)
                                .foregroundColor(.gray700)
                            Spacer()
                            Text(viewModel.state.housework.place)
                                .font(.subtitle6)
                                .foregroundColor(.gray700)
                        }
                        HStack {
                            Text("루틴")
                                .font(.subtitle6)
                                .foregroundColor(.gray700)
                            Spacer()
                            Text(viewModel.state.housework.routine.rawValue)
                                .font(.subtitle6)
                                .foregroundColor(.gray700)
                        }
                        HStack {
                            Text("마감일")
                                .font(.subtitle6)
                                .foregroundColor(.gray700)
                            Spacer()
                            Text(viewModel.state.housework.date.toKoreanDateString())
                                .font(.subtitle6)
                                .foregroundColor(.gray700)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.gray25)
                    )
                    
                    VStack(alignment: .leading) {
                        Text("집안일 기준 태그")
                            .font(.subtitle6)
                            .foregroundColor(.gray700)
                        LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
                            ForEach(viewModel.state.tags, id: \.self) { tag in
                                TagItemView(tag: tag)
                            }
                        }

                    }
                    .padding(.horizontal,20)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.gray25)
                    )
                }
                Spacer()
            }
            .frame(height: 560)
            
            MainButton(
                title: "추가하기",
                action: { viewModel.action(.didTapNextButton) },
                style: .bottoomMain
            )
            .padding(.bottom, 46)
        }
        .padding(.horizontal, 20)
    }

}

struct OverlappingProfileImages: View {
    let members: [Member]
    
    var body: some View {
        HStack(spacing: -38) {
            ForEach(members.prefix(2), id: \.id) { member in
                KFImage(member.profileImageUrl)
                    .placeholder {
                        Color.gray200
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 84, height: 84)
                    .clipShape(RoundedRectangle(cornerRadius: 34))
                    .overlay(
                        RoundedRectangle(cornerRadius: 34).stroke(.gray200, lineWidth: 1)
                    )
            }
        }
    }
}
struct TagItemView: View {
    let tag: String
    
    var body: some View {
        Text(tag)
            .font(.button2)
            .foregroundColor(.blue400)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(.blue400, lineWidth: 1)
            )
    }
}
