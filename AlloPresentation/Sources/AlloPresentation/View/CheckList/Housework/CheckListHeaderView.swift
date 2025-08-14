//
//  CheckListHeaderView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/9/25.
//

import SwiftUI

struct CheckListHeaderView: View {
    let selectedTabIndex: Int
    let myHouseworkCount: Int
    let allHouseworkCount: Int
    let isEditing: Bool
    let selectedHouseworkCount: Int
    let onSelectTab: (Int) -> Void
    let onCompleteEdit: () -> Void
    let onStartEdit: () -> Void
    var body: some View {
        HStack(
            alignment: .center,
            spacing: 20
        ) {
            if isEditing {
                HStack(
                    alignment: .center,
                    spacing: 4
                ) {
                    Text("선택됨")
                        .font(.body1)
                        .foregroundStyle(.gray900)
                    Text("\(selectedHouseworkCount)")
                        .font(.body1)
                        .foregroundStyle(selectedHouseworkCount > 0 ? .blue400 : .gray400)
                }
                .frame(height: 44)
            } else {
                Button(
                    action: {
                        onSelectTab(0)
                    }, label: {
                        HStack(
                            alignment: .center,
                            spacing: 4
                        ) {
                            Text("나의 집안일")
                                .font(.body1)
                                .foregroundStyle(selectedTabIndex == 0 ? .gray900 : .gray300)
                            Text("\(myHouseworkCount)")
                                .font(.body1)
                                .foregroundStyle(selectedTabIndex == 0 ? .blue400 : .gray300)
                        }
                        .frame(height: 44)
                    }
                )
                Button(
                    action: {
                        onSelectTab(1)
                    }, label: {
                        HStack(
                            alignment: .center,
                            spacing: 4
                        ) {
                            Text("우리집 집안일")
                                .font(.body1)
                                .foregroundStyle(selectedTabIndex == 1 ? .gray900 : .gray300)
                            Text("\(allHouseworkCount)")
                                .font(.body1)
                                .foregroundStyle(selectedTabIndex == 1 ? .blue400 : .gray300)
                        }
                        .frame(height: 44)
                    }
                )
            }
            Spacer(minLength: 0)
            Button(
                action: {
                    isEditing ? onCompleteEdit() : onStartEdit()
                }, label: {
                    if isEditing {
                        Text("완료")
                            .font(.button1)
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 32)
                            .background(.gray700)
                            .cornerRadius(.radius3)
                    } else {
                        Text("편집")
                            .font(.button1)
                            .foregroundStyle(.gray500)
                            .frame(width: 50, height: 32)
                    }
                }
            )
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}
