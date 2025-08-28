//
//  PlaceSelectionSheet.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/12/25.
//
import Foundation
import SwiftUI
import AlloDomain

public struct PlaceSelectionSheet: View {
    var placeClickAction: (String, Int) -> Void
    let coordinator: Coordinator
    @StateObject private var viewModel: PlaceSelectionViewModel
    
    public init(coordinator: Coordinator, viewModel: PlaceSelectionViewModel,
                placeClickAction: @escaping (String, Int) -> Void) {
        self.coordinator = coordinator
        _viewModel = StateObject(wrappedValue: viewModel)
        self.placeClickAction = placeClickAction
    }
    @State private var isAddingCategory = false
    @State private var newPlaceName = ""
    public var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(.gray200)
                .frame(width: 40, height: 4)
                .padding(.top, 13)
            
            Text("장소 선택")
                .font(.subtitle1)
                .foregroundStyle(.gray900)
                .padding(.top, 20)
                .padding(.bottom, 30)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(viewModel.state.places, id: \.placeId) { place in
                        PlaceButton(
                            title: place.name,
                            isSelected: viewModel.state.selectedCategory?.placeId == place.placeId
                        ) {
                            viewModel.action(.selectPlace(place))
                            placeClickAction(place.name, place.placeId)
                        }
                    }
                    // + 버튼
                    Button {
                        viewModel.action(.addNewPlace)
                    } label: {
                        Image(.iconPlus)
                    }
                    .contentShape(Rectangle())
                    .buttonStyle(.plain)
                    .background(
                        RoundedRectangle(cornerRadius: 12).fill(.gray25)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12).stroke(.gray25, lineWidth: 1)
                    )
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
            }
            .frame(maxHeight: 400) // 필요하면 최대 높이 제한
            Spacer()
        }
        .onAppear {
            Task {
                await viewModel.loadPlaces()
            }
        }
    }
}
