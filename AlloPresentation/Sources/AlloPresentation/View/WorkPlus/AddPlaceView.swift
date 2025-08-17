//
//  AddPlaceView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/16/25.
//

import SwiftUI

public struct AddPlaceView: View {
    
    public var body: some View {
        VStack(alignment: .leading) {
            TitleNavigationBar(title: "")
                .padding(.bottom, 50)
            Text("추가할 장소를 작성해주세요!")
                .font(.headline4)
                .foregroundColor(.black)
            Text("장소는 최대 10개까지 생성할 수 있어요.")
                .font(.body4)
            
            Spacer()
            MainButton(
                title: "새로운 장소 추가하기",
                action: { print("버튼 클릭") },
                style: .bottoomMain
            )
            .padding(.bottom, 46)
        }
        .padding(.horizontal,20)

    }

}

#Preview {
    AddPlaceView()
}
