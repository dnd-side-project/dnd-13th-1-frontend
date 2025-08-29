//
//  HomeTodayPlaceHouseworkView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/25/25.
//

import SwiftUI
import AlloDomain

struct HomeTodayPlaceHouseworkView: View {
    
    let houseworkPlaces: [String: [Housework]]
    let onTapAddHousework: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .top) {
                Text("오늘의 우리집 할 일")
                    .font(.headline4)
                    .foregroundStyle(.gray900)
                Spacer(minLength: 0)
                Button(
                    action: {
                        if houseworkPlaces.keys.count < 10 {
                            onTapAddHousework()
                        }
                    }, label: {
                        Text("+추가")
                            .font(.subtitle3)
                            .foregroundStyle(houseworkPlaces.keys.count < 10 ? .blue400 : .gray300)
                    }
                )
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
            VStack(spacing: 12) {
                ForEach(Array(houseworkPlaces.keys), id: \.self) { place in
                    let image: ImageResource = switch place {
                    case "방": .iconSofa
                    case "욕실": .iconToilet
                    case "세탁": .iconWashingMachine
                    case "주방": .iconKitchen
                    case "기타": .iconEtc
                    default: [
                        .iconExample1,
                        .iconExample2,
                        .iconExample3,
                        .iconExample4,
                        .iconExample5
                    ].randomElement() ?? .iconEtc
                    }
                    HomePlaceCell(
                        image: image,
                        place: place,
                        count: houseworkPlaces[place]?.count ?? 0
                    )
                }
            }.frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 20)
    }
}
