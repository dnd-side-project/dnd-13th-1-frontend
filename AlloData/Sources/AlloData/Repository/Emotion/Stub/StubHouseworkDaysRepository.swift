//
//  StubHouseworkDaysRepository.swift
//  AlloData
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation
import AlloDomain

public struct StubHouseworkDaysRepository: HouseworkDaysRepository {
    public init() {}
    
    public func fetchSevenDaysHousework() async throws -> [HouseworkSevendays] {
        return [
            HouseworkSevendays(
                date: "2025-08-17",
                houseWorks: [
                    HouseworkRecent(id: 1, place: "주방", title: "가스레인지 청소"),
                    HouseworkRecent(id: 2, place: "거실", title: "바닥 청소")
                ]
            ),
            HouseworkSevendays(
                date: "2025-08-16",
                houseWorks: [
                    HouseworkRecent(id: 3, place: "욕실", title: "변기 청소"),
                    HouseworkRecent(id: 4, place: "주방", title: "싱크대 정리")
                ]
            ),
            HouseworkSevendays(
                date: "2025-08-15",
                houseWorks: [
                    HouseworkRecent(id: 5, place: "거실", title: "청소기 돌리기"),
                    HouseworkRecent(id: 6, place: "침실", title: "이불 정리")
                ]
            ),
            HouseworkSevendays(
                date: "2025-08-14",
                houseWorks: [
                    HouseworkRecent(id: 7, place: "주방", title: "냉장고 정리"),
                    HouseworkRecent(id: 8, place: "욕실", title: "거울 닦기")
                ]
            ),
            HouseworkSevendays(
                date: "2025-08-13",
                houseWorks: [
                    HouseworkRecent(id: 9, place: "거실", title: "청소기 돌리기"),
                    HouseworkRecent(id: 10, place: "주방", title: "식기 정리")
                ]
            ),
            HouseworkSevendays(
                date: "2025-08-12",
                houseWorks: [
                    HouseworkRecent(id: 11, place: "침실", title: "책상 정리"),
                    HouseworkRecent(id: 12, place: "거실", title: "창문 닦기")
                ]
            ),
            HouseworkSevendays(
                date: "2025-08-11",
                houseWorks: [
                    HouseworkRecent(id: 13, place: "주방", title: "바닥 청소"),
                    HouseworkRecent(id: 14, place: "욕실", title: "타일 청소")
                ]
            )
        ]
    }
}
