//
//  HouseworkRepositoryImpl.swift
//  AlloData
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation
import AlloDomain

final class HouseworkRepositoryImpl: HouseworkRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    private let dateFormatterYYYYMMDD: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func getHaveHousework(from: Date, to: Date) async throws -> [Date : Bool] {
        guard let groupId = UserDefaultsService.groupId else { return [:] }
        let fromString = dateFormatterYYYYMMDD.string(from: from)
        let toString = dateFormatterYYYYMMDD.string(from: to)
        let dto = try await networkService.getHaveHousework(groupId, from: fromString, to: toString)
        var result: [Date: Bool] = [:]
        for element in dto {
            if let date = dateFormatterYYYYMMDD.date(from: element.date) {
                result[date] = element.hasHouseWork
            }
        }
        return result
    }
    
    func getHouseworkList(_ date: Date) async throws -> (
        myHouseworksLeft: [Housework],
        ourHouseworksLeft: [Housework],
        myHouseworksCompleted: [Housework],
        ourHouseworksCompleted: [Housework]
    ) {
        guard let groupId = UserDefaultsService.groupId else {
            return ([], [], [], [])
        }
        let dateString = dateFormatterYYYYMMDD.string(from: date)
        let dto = try await networkService.getHouseworkList(groupId, date: dateString)
        func mapHouseworks(_ list: [GetHouseworkResponseDTO.Housework]) -> [Housework] {
            return list.compactMap { item in
                guard let workDate = dateFormatterYYYYMMDD.date(from: item.houseworkDate) else { return nil }
                let members: [Member] = item.houseworkMembers.compactMap { m in
                    let url = URL(string: m.memberProfileImageUrl) ?? URL(string: "https://example.com/placeholder.png")!
                    return Member(id: m.memberId, name: m.memberNickName, profileImageUrl: url)
                }
                return Housework(
                    id: item.houseworkId,
                    place: "",
                    title: item.houseworkTitle,
                    member: members,
                    date: workDate,
                    isDone: false,
                    routine: .none,
                    tags: item.houseworkTag
                )
            }
        }
        let myLeft = mapHouseworks(dto.myHouseWorkLeft)
        let ourLeft = mapHouseworks(dto.ourHouseWorkLeft)
        let myDone = mapHouseworks(dto.myHouseWorkCompleted)
        let ourDone = mapHouseworks(dto.ourHouseWorkCompleted)
        return (myLeft, ourLeft, myDone, ourDone)
    }
    
    func completeHousework(_ housework: Housework) async throws {
        try await networkService.completeHousework(housework.id)
    }
    
    func addHousework(_ housework: Housework) async throws {
        guard let groupId = UserDefaultsService.groupId else { return }
        // Domain 모델만으로는 placeId, tag 식별자 등 추가 정보가 부족합니다.
        // 최소 매핑으로 title/members/date/routine만 전송하고, 나머지는 기본값 처리합니다.
        let memberIds = housework.member.map { $0.id }
        let startDate = dateFormatterYYYYMMDD.string(from: housework.date)
        let request = AddHouseworkScheduleRequestDTO(
            houseWorkName: housework.title,
            placeId: 0,
            tags: [],
            members: memberIds,
            startDate: startDate,
            dueDate: startDate,
            routinePolicy: housework.routine.rawValue,
            dayOfTheWeek: [],
            isNotified: false
        )
        _ = try await networkService.addHouseworkSchedule(groupId, request)
    }
    
    func deleteHousework(_ housework: Housework) async throws {
        try await networkService.deleteHousework(housework.id)
    }
    
    func getHouseworkDetail(id: Int) async throws -> HouseworkDetail {
        let dto = try await networkService.getHouseworkDetail(id)
        guard let date = dateFormatterYYYYMMDD.date(from: dto.houseworkDate) else {
            return HouseworkDetail(id: dto.houseworkId, title: dto.houseworkTitle, tags: dto.houseworkTag.map { $0.name }, date: Date(), members: dto.houseworkMembers.map { Member(id: $0.memberId, name: $0.memberNickName, profileImageUrl: URL(string: "https://example.com/placeholder.png")!) })
        }
        return HouseworkDetail(id: dto.houseworkId, title: dto.houseworkTitle, tags: dto.houseworkTag.map { $0.name }, date: date, members: dto.houseworkMembers.map { Member(id: $0.memberId, name: $0.memberNickName, profileImageUrl: URL(string: "https://example.com/placeholder.png")!) })
    }
    
    func getMyRecentHousework(receiverId: Int) async throws -> [RecentHouseworkDay] {
        guard let groupId = UserDefaultsService.groupId else { return [] }
        let dto = try await networkService.getMyRecentHouseworkList(groupId, receiverId: receiverId)
        return dto.compactMap { day -> RecentHouseworkDay? in
            guard let date = dateFormatterYYYYMMDD.date(from: day.date) else { return nil }
            let items = day.houseWorks.map { RecentHouseworkItem(id: $0.houseWorkId, name: $0.houseWorkName, placeName: $0.placeName) }
            return RecentHouseworkDay(date: date, items: items)
        }
    }
    
    func getTodayPlaceHousework(placeId: Int) async throws -> TodayPlaceHousework {
        let dto = try await networkService.getTodayPlaceHousework(placeId)
        func mapItems(_ arr: [GetTodayPlaceHouseworkResponseDTO.HouseWork]) -> [TodayHouseworkItem] {
            arr.map { item in
                let urls = item.houseWorkMembers.compactMap { URL(string: $0.memberProfileImageUrl) }
                return TodayHouseworkItem(id: item.houseWorkId, title: item.houseWorkTitle, memberProfileImageUrls: urls)
            }
        }
        return TodayPlaceHousework(my: mapItems(dto.myHouseWork), our: mapItems(dto.ourHouseWork))
    }
}
