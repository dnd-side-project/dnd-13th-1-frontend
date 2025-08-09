//
//  CheckListView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/9/25.
//

import SwiftUI
import AlloDomain

struct CheckListView: View {
    @StateObject var viewModel: CheckListViewModel
    var body: some View {
        ZStack(
            alignment: .center
        ) {
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
                        weekString: "",
                        onTapDatePicker: {
                            viewModel.action(.datePickerAction(.willPresentDatePicker))
                        },
                        onTapToday: {
                            viewModel.action(.weekCalendarAction(.didTapTodayButton))
                        },
                        onTapPreviousWeek: {
                            viewModel.action(.weekCalendarAction(.moveToPast))
                        },
                        onTapNextWeek: {
                            viewModel.action(.weekCalendarAction(.moveToFuture))
                        }
                    )
                    CalendarWeekScrollView(
                        selectedDayOfTheWeek: viewModel.state.calendarState.selectedDayOfTheWeek,
                        prevWeekDates: viewModel.state.calendarState.pastWeek,
                        presentWeekDates: viewModel.state.calendarState.presentWeek,
                        nextWeekDates: viewModel.state.calendarState.futureWeek,
                        onTap: { date in
                            viewModel.action(.weekCalendarAction(.selectDate(date)))
                        },
                        scrollToPast: {
                            viewModel.action(.weekCalendarAction(.moveToPast))
                        },
                        scrollToFuture: {
                            viewModel.action(.weekCalendarAction(.moveToFuture))
                        },
                        scrollPosition: $viewModel.state.calendarState.scrollPosition
                    )
                }
                .padding(.top, 8)
                .padding(.bottom, 15)
                .frame(maxWidth: .infinity)
                .cornerRadius(.radius3, corners: [.bottomLeft, .bottomRight])
                CheckListHeaderView(
                    selectedTabIndex: viewModel.state.checkListState.selectedTabIndex,
                    myHouseworkCount: viewModel.state.checkListState.myHouseworksLeft.count,
                    allHouseworkCount: viewModel.state.checkListState.ourHouseworksLeft.count,
                    isEditing: viewModel.state.checkListState.isEditing,
                    selectedHouseworkCount: viewModel.state.checkListState.selectedHouseworks.count,
                    onSelectTab: { index in
                        viewModel.action(.checkListAction(.selectTab(index)))
                    },
                    onCompleteEdit: {
                        viewModel.action(.checkListAction(.finishEditing))
                    },
                    onStartEdit: {
                        viewModel.action(.checkListAction(.startEditing))
                    }
                )
                ForEach(
                    viewModel.state.checkListState.selectedTabIndex == 0
                    ? viewModel.state.checkListState.myHouseworksLeft
                    : viewModel.state.checkListState.ourHouseworksLeft
                ) { housework in
                    VStack(alignment: .center, spacing: 12) {
                        CheckListCell(
                            housework: housework,
                            isEditing: viewModel.state.checkListState.isEditing,
                            status:
                                viewModel.state.checkListState.selectedHouseworks.contains(housework)
                            ? .selected
                            : .normal,
                            isMyHousework: viewModel.state.checkListState.myHouseworksLeft.contains(housework),
                            onCheckButtonTap: { housework in
                                viewModel.action(.checkListAction(.selectHousework(housework)))
                            }
                        )
                    }
                }
                /// 완료한 집안일이 있는 경우에만 보여줍니다
                if viewModel.state.checkListState.selectedTabIndex == 0
                    ? viewModel.state.checkListState.myHouseworksCompleted.count > 0
                    : viewModel.state.checkListState.ourHouseworksCompleted.count > 0 {
                    CheckListCompletedHeaderView(
                        count: viewModel.state.checkListState.selectedTabIndex == 0
                        ? viewModel.state.checkListState.myHouseworksLeft.count
                        : viewModel.state.checkListState.ourHouseworksLeft.count,
                        isOpened: viewModel.state.checkListState.showsCompleted,
                        onTap: {
                            viewModel.action(.checkListAction(.didTapCompletedHouseworkListButton))
                        }
                    )
                    .padding(.top, 20)
                    ForEach(
                        viewModel.state.checkListState.selectedTabIndex == 0
                        ? viewModel.state.checkListState.myHouseworksCompleted
                        : viewModel.state.checkListState.ourHouseworksCompleted
                    ) { housework in
                        VStack(alignment: .center, spacing: 12) {
                            CheckListCell(
                                housework: housework,
                                isEditing: viewModel.state.checkListState.isEditing,
                                status: .completed,
                                isMyHousework: viewModel.state.checkListState.myHouseworksLeft.contains(housework),
                                onCheckButtonTap: { housework in
                                    viewModel.action(.checkListAction(.selectHousework(housework)))
                                }
                            )
                        }
                    }
                }
            }
            .padding(.bottom, 20)
            .background(.gray50)
            if viewModel.state.isLoading {
                ProgressView()
            }
            CheckListFloatingButton(viewModel: viewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
