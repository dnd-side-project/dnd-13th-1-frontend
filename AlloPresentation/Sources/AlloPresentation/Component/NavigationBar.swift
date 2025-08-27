//
//  NavigationBar.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/27/25.
//

import SwiftUI

struct NavigationBar: View {
    
    let onTapGroup: () -> Void
    let onTapNotification: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Image(.logo)
                .resizable()
                .frame(width: 48, height: 24)
            Spacer(minLength: 0)
            Button(
                action: {
                    onTapGroup()
                }, label: {
                    Image(.iconGroup)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            ).padding(.trailing, 12)
            Button(
                action: {
                    onTapNotification()
                }, label: {
                    Image(.iconBell)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            )
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
    }
}
