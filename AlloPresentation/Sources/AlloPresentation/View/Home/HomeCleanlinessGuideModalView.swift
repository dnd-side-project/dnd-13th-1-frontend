//
//  HomeCleanlinessGuideModalView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/27/25.
//

import SwiftUI

struct HomeCleanlinessGuideModalView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Text("알로")
                        .font(.subtitle1)
                        .foregroundStyle(.blue300)
                    Text("의 모습이 바뀌었나요?")
                        .font(.subtitle1)
                        .foregroundStyle(.gray900)
                    Spacer(minLength: 0)
                    Button(
                        action: {
                            isPresented = false
                        }, label: {
                            Image(.iconClose)
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    )
                }
                .padding(.bottom, 12)
                Text("우리집 청결도 달성이 낮을 수록 알로가 더러워져요. 깨끗하고 행복한 알로를 위해 오늘의 집안일을 마무리하세요!")
                    .font(.subtitle7)
                    .foregroundStyle(.gray700)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .lineLimit(.none)
                    .padding(.bottom, 16)
                HStack (alignment: .top, spacing: 9.5) {
                    HomeCleanlinessGuideCheckPointView(
                        image: .illustrationCleanlinessFirst,
                        description: "0~39%"
                    )
                    Image(.iconDot)
                        .resizable()
                        .frame(width: 36, height: 5)
                        .padding(.top, 22)
                    HomeCleanlinessGuideCheckPointView(
                        image: .illustrationCleanlinessSecond,
                        description: "40~79%"
                    )
                    Image(.iconDot)
                        .resizable()
                        .frame(width: 36, height: 5)
                        .padding(.top, 22)
                    HomeCleanlinessGuideCheckPointView(
                        image: .illustrationCleanlinessThird,
                        description: "80~100%"
                    )
                }
            }
            .padding(.horizontal, 26)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(.radius3)
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HomeCleanlinessGuideCheckPointView: View {
    let image: ImageResource
    let description: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(image)
                .resizable()
                .frame(width: 62, height: 47)
                .padding(.bottom, 8)
            Text("달성도")
                .font(.caption3)
                .foregroundStyle(.gray700)
                .padding(.bottom, -4)
            Text(description)
                .font(.caption3)
                .foregroundStyle(.gray700)
        }
    }
}
