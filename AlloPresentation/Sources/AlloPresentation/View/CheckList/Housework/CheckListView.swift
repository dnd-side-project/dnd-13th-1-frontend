//
//  CheckListView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/9/25.
//

import SwiftUI
import AlloDomain

struct CheckListView: View {
    
    let houseworks: [Housework]
    
    var body: some View {
        VStack(
            alignment: .center,
            spacing: 0
        ) {
            VStack(
                alignment: .center,
                spacing: 0
            ) {
                // TODO: 네비바 추가
                CalendarHeaderView(
                    onTapDatePicker: <#T##() -> Void#>,
                    onTapToday: <#T##() -> Void#>,
                    onTapPreviousWeek: <#T##() -> Void#>,
                    onTapNextWeek: <#T##() -> Void#>
                )
                CalendarWeekScrollView(
                    selectedDayOfTheWeek: <#T##DayOfTheWeek#>,
                    prevWeekDates: <#T##[Date : Bool]#>,
                    presentWeekDates: <#T##[Date : Bool]#>,
                    nextWeekDates: <#T##[Date : Bool]#>,
                    onTap: <#T##(Date) -> Void#>,
                    scrollToPast: <#T##() -> Void#>,
                    scrollToFuture: <#T##() -> Void#>,
                    scrollPosition: <#T##Binding<Int?>#>
                )
            }
            .padding(.top, 8)
            .padding(.bottom, 15)
            .frame(maxWidth: .infinity)
            .cornerRadius(.radius3, corners: [.bottomLeft, .bottomRight])
            CheckListHeaderView(
                selectedTabIndex: <#T##Int#>,
                myHouseworkCount: <#T##Int#>,
                allHouseworkCount: <#T##Int#>,
                isEditing: <#T##Bool#>,
                selectedHouseworkCount: <#T##Int#>,
                onSelectTab: <#T##(Int) -> Void#>,
                onCompleteEdit: <#T##() -> Void#>,
                onStartEdit: <#T##() -> Void#>
            )
            ForEach(houseworks) { housework in
                VStack(alignment: .center, spacing: 12) {
                    CheckListCell(
                        houseWorkId: <#T##Int#>,
                        isEditing: <#T##Bool#>,
                        status: <#T##CheckListCell.CheckListCellStatus#>,
                        place: <#T##String#>,
                        houseWorkTitle: <#T##String#>,
                        myProfileImageUrl: housework.member[0].profileImageUrl,
                        membersProfileImageUrl: housework.member
                            .filter { $0.id != 0 }
                            .map { $0.profileImageUrl },
                        onCheckButtonTap: <#T##(Int) -> Void#>
                    )
                }
            }
            // 완료한 집안일이 있는 경우
            if houseworks.filter({ $0.isDone }).count > 0 {
                CheckListCompletedHeaderView(
                    count: houseworks.filter({ $0.isDone }).count,
                    isOpened: <#T##Bool#>,
                    onTap: <#T##() -> Void#>
                )
                ForEach(houseworks) { housework in
                    VStack(alignment: .center, spacing: 12) {
                        CheckListCell(
                            houseWorkId: <#T##Int#>,
                            isEditing: <#T##Bool#>,
                            status: <#T##CheckListCell.CheckListCellStatus#>,
                            place: <#T##String#>,
                            houseWorkTitle: <#T##String#>,
                            myProfileImageUrl: housework.member[0].profileImageUrl,
                            membersProfileImageUrl: housework.member
                                .filter { $0.id != 0 }
                                .map { $0.profileImageUrl },
                            onCheckButtonTap: <#T##(Int) -> Void#>
                        )
                    }
                }
            }
        }
        .background(.gray50)
    }
}
