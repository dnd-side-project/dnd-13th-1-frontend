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
    var placeClickAction: (String) -> Void
    let coordinator: Coordinator
    @StateObject private var viewModel: PlaceSelectionViewModel

    public init(coordinator: Coordinator, viewModel: PlaceSelectionViewModel,
                placeClickAction: @escaping (String) -> Void) {
        self.coordinator = coordinator
        _viewModel = StateObject(wrappedValue: viewModel)
        self.placeClickAction = placeClickAction
    }

    @State private var selectedCategory: String = "방"
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
            
            VStack(spacing: 12) {
                ForEach(viewModel.state.places, id: \.placeId) { place in
                    PlaceButton(
                        title: place.name,
                        isSelected: viewModel.selectedCategory?.placeId == place.placeId
                    ) {
                        viewModel.selectedCategory = place
                        placeClickAction(place.name)
                    }
                }
                
                // + 버튼
                Button {
                    coordinator.dismissSheet()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        coordinator.presentFullScreenCover(AppFullScreenCover.addHousePlace)
                    }
                    isAddingCategory = true
                } label: {
                    Image(.iconPlus)
                        .frame(maxWidth: .infinity, minHeight: 56)
                }
                .buttonStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: 12).fill(.gray25)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12).stroke(.gray25, lineWidth: 1)
                )
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        Spacer()
            .onAppear {
                    Task {
                        await viewModel.loadPlaces()
                    }
                }
        .animation(.easeInOut(duration: 0.15), value: selectedCategory)
    }
}
