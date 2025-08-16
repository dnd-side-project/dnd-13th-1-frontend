//
//  CalendarDateSheet.swift
//  AlloPresentation
//
//  Created by 김민솔 on 8/17/25.
//

import SwiftUI

public struct CalendarDateSheet: View {
    var dateClickAction: (String) -> Void
    
    public init(dateClickAction: @escaping (String) -> Void) {
        self.dateClickAction = dateClickAction
    }
    public var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
            Text("마감일 선택")
                .font(.subtitle1)
                .foregroundColor(.gray900)
            
        }
        Spacer()
    }

}
