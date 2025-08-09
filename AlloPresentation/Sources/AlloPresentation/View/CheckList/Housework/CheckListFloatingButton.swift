//
//  CheckListFloatingButton.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/10/25.
//

import SwiftUI

struct CheckListFloatingButton: View {
    @ObservedObject var viewModel: CheckListViewModel
    
    var body: some View {
        if viewModel.state.checkListState.isEditing {
            Button(
                action: {
                    viewModel.action(.checkListAction(.deleteSelectedHousework))
                }, label: {
                    Image(
                        viewModel.state.checkListState.selectedHouseworks.count > 0
                        ? .iconButtonTrashGray900
                        : .iconButtonTrashGray300
                    )
                    .frame(width: 50, height: 50, alignment: .bottomTrailing)
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
            )
        } else {
            Button(
                action: {
                    viewModel.action(.checkListAction(.didTapAddHouseworkButton))
                }, label: {
                    Image(.iconButtonAdd)
                        .frame(width: 50, height: 50, alignment: .bottomTrailing)
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                }
            )
            
        }

    }
}
