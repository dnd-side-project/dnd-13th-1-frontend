//
//  AlarmSettngView.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/12/25.
//

import SwiftUI

struct AlarmSettngView: View {
    @Binding var toggleOn:Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("알림설정")
                    .font(.subtitle3)
                    .foregroundColor(.gray400)
                Text("알림설정을 해두면 당일에 알림을 보낼게요.")
                    .font(.caption2)
                    .foregroundColor(.gray400)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .layoutPriority(1)
            Spacer(minLength: 8)
            Toggle(isOn: $toggleOn) {
                EmptyView()
            }
            .tint(.blue400)
        }
        .frame(height: 56)
    }
}
