//
//  StubHouseworkRepository.swift
//  AlloData
//
//  Created by 황채웅 on 8/10/25.
//

import Foundation
import AlloDomain

public struct StubHouseworkRepository: HouseworkRepository {
    // 더미 데이터: Member
    private let members: [Member] = [
        Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),
        Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/51.jpg")!),
        Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/52.jpg")!)
    ]
    
    // 더미 데이터: Housework
    private let houseworks: [Housework] = {
        let calendar = Calendar.current
        let today = Date()
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        
        return [
            Housework(id: 1, place: "주방", title: "설거지", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!)], date: today, isDone: false, routine: .everyday),
            Housework(id: 2, place: "거실", title: "청소", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/40.jpg")!), Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/10.jpg")!)], date: today, isDone: true, routine: .everyWeek),
            Housework(id: 3, place: "화장실", title: "변기 청소", member: [Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/5.jpg")!)], date: yesterday, isDone: false, routine: .biweek),
            Housework(id: 4, place: "베란다", title: "창문 닦기", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/1.jpg")!), Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!)], date: tomorrow, isDone: false, routine: .everyMonth),
            Housework(id: 5, place: "주방", title: "냉장고 정리", member: [Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/53.jpg")!)], date: today, isDone: true, routine: .none)
        ]
    }()
    
    public func getHaveHousework(from: Date, to: Date) async throws -> [Date: Bool] {
        var result: [Date: Bool] = [:]
        let calendar = Calendar.current
        
        // 날짜 범위 내 각 날짜에 대해 집안일 존재 여부 확인
        var currentDate = from
        while currentDate <= to {
            let startOfDay = calendar.startOfDay(for: currentDate)
            let hasHousework = houseworks.contains { housework in
                calendar.isDate(housework.date, inSameDayAs: startOfDay)
            }
            result[startOfDay] = hasHousework
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return result
    }
    
    public func getHouseworkList(_ date: Date) async throws -> (myHouseworksLeft: [Housework], ourHouseworksLeft: [Housework], myHouseworksCompleted: [Housework], ourHouseworksCompleted: [Housework]) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        
        // 현재 사용자 (예: 김철수, id: 1)로 가정
        let currentUserId = 1
        
        // 집안일 필터링
        let filteredHouseworks = houseworks.filter { housework in
            calendar.isDate(housework.date, inSameDayAs: startOfDay)
        }
        
        // 개인/공유 및 완료/미완료로 구분
        let myHouseworksLeft = filteredHouseworks.filter { housework in
            housework.member.count == 1 && housework.member.contains { $0.id == currentUserId } && !housework.isDone
        }
        let ourHouseworksLeft = filteredHouseworks.filter { housework in
            housework.member.count > 1 && housework.member.contains { $0.id == currentUserId } && !housework.isDone
        }
        let myHouseworksCompleted = filteredHouseworks.filter { housework in
            housework.member.count == 1 && housework.member.contains { $0.id == currentUserId } && housework.isDone
        }
        let ourHouseworksCompleted = filteredHouseworks.filter { housework in
            housework.member.count > 1 && housework.member.contains { $0.id == currentUserId } && housework.isDone
        }
        
        return (myHouseworksLeft, ourHouseworksLeft, myHouseworksCompleted, ourHouseworksCompleted)
    }
    
    public func completeHousework(_ housework: Housework) async throws {
        dump("Completed housework: \(housework.title)")
    }
    
    public func addHousework(_ housework: Housework) async throws {
        dump("Added housework: \(housework.title)")
    }
    
    public func deleteHousework(_ housework: Housework) async throws {
        dump("Deleted housework: \(housework.title)")
    }
}
