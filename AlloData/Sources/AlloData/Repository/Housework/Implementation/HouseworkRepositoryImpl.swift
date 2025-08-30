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
               // guard let workDate = dateFormatterYYYYMMDD.date(from: item.houseWorkDate) else { return nil }
                let members: [Member] = item.houseWorkMembers.map { m in
                    let url = m.memberProfileImageUrl != nil ? URL(string: m.memberProfileImageUrl!) : nil
                    return Member(id: m.memberId, name: m.memberNickName, profileImageUrl: url)
                }

                let workDate = dateFormatterYYYYMMDD.date(from: item.houseWorkDate) ?? Date() // 실패하면 오늘 날짜
                return Housework(
                    id: item.houseWorkId,
                    place: item.placeName,
                    title: item.houseWorkTitle,
                    member: members,
                    date: workDate,
                    isDone: false,
                    routine: .none,
                    tags: item.houseWorkTag.map{ $0.name }
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
    
    func addHousework(housework: Housework) async throws {
        guard let groupId = UserDefaultsService.groupId else {
            print("[AddHousework] groupId is nil")
            return
        }
        let startDate = dateFormatterYYYYMMDD.string(from: housework.date)
        let request = AddHouseworkScheduleRequestDTO(
            houseWorkName: housework.houseWorkName,
            placeId: housework.placeAdd,
            tags: housework.tagsAdd,
            members: housework.members,
            startDate: startDate,
            dueDate: startDate,
            routinePolicy: housework.routineAdd.rawValue,
            dayOfWeek: housework.dayOfTheWeek.map { $0.rawValue },
            isNotified: false
        )
        print("[AddHousework] 요청 전 - groupId: \(groupId), request: \(request)")
        let response = try await networkService.addHouseworkSchedule(groupId, request)
        print("[AddHousework] 요청 후 - response: \(response)")
    }
    
    func deleteHousework(_ housework: Housework) async throws {
        try await networkService.deleteHousework(housework.id)
    }
    
    func getHouseworkDetail(id: Int) async throws -> HouseworkDetail {
        do {
            let dto = try await networkService.getHouseworkDetail(id)
            
            guard let date = dateFormatterYYYYMMDD.date(from: dto.houseWorkDate) else {
                print("⚠️ [Repository] 날짜 변환 실패, 기본값(Date()) 사용")
                return HouseworkDetail(
                    id: dto.houseWorkId,
                    title: dto.houseWorkTitle,
                    placeName: dto.placeName,
                    tags: dto.houseWorkTag.map { $0.name },
                    date: Date(),
                    members: dto.houseWorkMembers.map {
                        Member(id: $0.memberId, name: $0.memberNickName,
                               profileImageUrl: nil)
                    }
                )
            }
            
            return HouseworkDetail(
                id: dto.houseWorkId,
                title: dto.houseWorkTitle,
                placeName: dto.placeName,
                tags: dto.houseWorkTag.map { $0.name },
                date: date,
                members: dto.houseWorkMembers.map {
                    Member(id: $0.memberId, name: $0.memberNickName,
                           profileImageUrl: nil)
                }
            )
            
        } catch {
            throw error
        }
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
                let urls = item.houseWorkMembers.map { member in
                    if let urlString = member.memberProfileImageUrl {
                        return URL(string: urlString)
                    } else {
                        return nil
                    }
                }
                return TodayHouseworkItem(id: item.houseWorkId, title: item.houseWorkTitle, memberProfileImageUrls: urls)
            }
        }
        return TodayPlaceHousework(my: mapItems(dto.myHouseWork), our: mapItems(dto.ourHouseWork))
    }
}
