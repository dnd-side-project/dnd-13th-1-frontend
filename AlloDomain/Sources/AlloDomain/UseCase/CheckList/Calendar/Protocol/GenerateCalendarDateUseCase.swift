//
//  GenerateCalendarDateUseCase.swift
//  AlloDomain
//
//  Created by 황채웅 on 8/9/25.
//

import Foundation

/// 프로토콜은 외부 모듈에서 접근할 수 있도록 public 선언합니다
public protocol GenerateCalendarDateUseCase {
    func execute(_ baseDate: Date) -> (previousWeek: [Date], currentWeek: [Date], nextWeek: [Date])
}
