////
////  StubHouseworkRepository.swift
////  AlloData
////
////  Created by 황채웅 on 8/10/25.
////
//
//import Foundation
//import AlloDomain
//
import Foundation
import AlloDomain

struct StubHouseworkRepository: HouseworkRepository {
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
            Housework(id: 1, place: "주방", title: "설거지", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),
                                                                 Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),
                                                                 Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!)], date: today, isDone: false, routine: .everyday,tags: [])
            //            Housework(id: 2, place: "거실", title: "청소", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/40.jpg")!), Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/10.jpg")!)], date: today, isDone: true, routine: .everyWeek),
            //            Housework(id: 3, place: "화장실", title: "변기 청소", member: [Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/5.jpg")!)], date: yesterday, isDone: false, routine: .biweek),
            //            Housework(id: 4, place: "베란다", title: "창문 닦기", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/1.jpg")!), Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!)], date: tomorrow, isDone: false, routine: .everyMonth),
            //            Housework(id: 5, place: "주방", title: "냉장고 정리", member: [Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/53.jpg")!)], date: today, isDone: true, routine: .none),
            //            Housework(id: 6, place: "주방", title: "설거지", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!)], date: today, isDone: false, routine: .everyday),
            //            Housework(id: 7, place: "거실", title: "청소", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/40.jpg")!), Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/10.jpg")!)], date: today, isDone: true, routine: .everyWeek),
            //            Housework(id: 8, place: "화장실", title: "변기 청소", member: [Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/5.jpg")!)], date: yesterday, isDone: false, routine: .biweek),
            //            Housework(id: 9, place: "베란다", title: "창문 닦기", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/1.jpg")!), Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!)], date: tomorrow, isDone: false, routine: .everyMonth),
            //            Housework(id: 10, place: "주방", title: "냉장고 정리", member: [Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/53.jpg")!)], date: today, isDone: true, routine: .none),
            //            Housework(id: 11, place: "주방", title: "설거지", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!)], date: today, isDone: false, routine: .everyday),
            //            Housework(id: 12, place: "거실", title: "청소", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/40.jpg")!), Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/10.jpg")!)], date: today, isDone: true, routine: .everyWeek),
            //            Housework(id: 13, place: "화장실", title: "변기 청소", member: [Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/5.jpg")!)], date: yesterday, isDone: false, routine: .biweek),
            //            Housework(id: 14, place: "베란다", title: "창문 닦기", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/1.jpg")!), Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!)], date: tomorrow, isDone: false, routine: .everyMonth),
            //            Housework(id: 15, place: "주방", title: "냉장고 정리", member: [Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/53.jpg")!)], date: today, isDone: true, routine: .none),
            //            Housework(id: 16, place: "주방", title: "설거지", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),
            //                                                                  Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),
            //                                                                  Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!),Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!)], date: today, isDone: false, routine: .everyday),
            //            Housework(id: 17, place: "거실", title: "청소", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/40.jpg")!), Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/10.jpg")!)], date: today, isDone: true, routine: .everyWeek),
            //            Housework(id: 18, place: "화장실", title: "변기 청소", member: [Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/5.jpg")!)], date: yesterday, isDone: false, routine: .biweek),
            //            Housework(id: 19, place: "베란다", title: "창문 닦기", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/1.jpg")!), Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!)], date: tomorrow, isDone: false, routine: .everyMonth),
            //            Housework(id: 20, place: "주방", title: "냉장고 정리", member: [Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/53.jpg")!)], date: today, isDone: true, routine: .none),
            //            Housework(id: 21, place: "주방", title: "설거지", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!)], date: today, isDone: false, routine: .everyday),
            //            Housework(id: 22, place: "거실", title: "청소", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/40.jpg")!), Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/10.jpg")!)], date: today, isDone: true, routine: .everyWeek),
            //            Housework(id: 23, place: "화장실", title: "변기 청소", member: [Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/5.jpg")!)], date: yesterday, isDone: false, routine: .biweek),
            //            Housework(id: 24, place: "베란다", title: "창문 닦기", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/1.jpg")!), Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!),Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!),
            //                                                                     Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!),Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!)], date: tomorrow, isDone: false, routine: .everyMonth),
            //            Housework(id: 25, place: "주방", title: "냉장고 정리", member: [Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/53.jpg")!)], date: today, isDone: true, routine: .none),
            //            Housework(id: 26, place: "주방", title: "설거지", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!)], date: today, isDone: false, routine: .everyday),
            //            Housework(id: 27, place: "거실", title: "청소", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/40.jpg")!), Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/10.jpg")!)], date: today, isDone: true, routine: .everyWeek),
            //            Housework(id: 28, place: "화장실", title: "변기 청소", member: [Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/5.jpg")!)], date: yesterday, isDone: false, routine: .biweek),
            //            Housework(id: 29, place: "베란다", title: "창문 닦기", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/1.jpg")!), Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!)], date: tomorrow, isDone: false, routine: .everyMonth),
            //            Housework(id: 30, place: "주방", title: "냉장고 정리", member: [Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/53.jpg")!)], date: today, isDone: true, routine: .none),
            //            Housework(id: 31, place: "주방", title: "설거지", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!)], date: today, isDone: false, routine: .everyday),
            //            Housework(id: 32, place: "거실", title: "청소", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/40.jpg")!), Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/10.jpg")!)], date: today, isDone: true, routine: .everyWeek),
            //            Housework(id: 33, place: "화장실", title: "변기 청소", member: [Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/5.jpg")!)], date: yesterday, isDone: false, routine: .biweek),
            //            Housework(id: 34, place: "베란다", title: "창문 닦기", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/1.jpg")!), Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!)], date: tomorrow, isDone: false, routine: .everyMonth),
            //            Housework(id: 35, place: "주방", title: "냉장고 정리", member: [Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/53.jpg")!)], date: today, isDone: true, routine: .none),
            //            Housework(id: 36, place: "주방", title: "설거지", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!)], date: today, isDone: false, routine: .everyday),
            //            Housework(id: 37, place: "거실", title: "청소", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/40.jpg")!), Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/10.jpg")!)], date: today, isDone: true, routine: .everyWeek),
            //            Housework(id: 38, place: "화장실", title: "변기 청소", member: [Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/5.jpg")!)], date: yesterday, isDone: false, routine: .biweek),
            //            Housework(id: 39, place: "베란다", title: "창문 닦기", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/1.jpg")!), Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!)], date: tomorrow, isDone: false, routine: .everyMonth),
            //            Housework(id: 40, place: "주방", title: "냉장고 정리", member: [Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/53.jpg")!)], date: today, isDone: true, routine: .none),
            //            Housework(id: 41, place: "주방", title: "설거지", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!)], date: today, isDone: false, routine: .everyday),
            //            Housework(id: 42, place: "거실", title: "청소", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/40.jpg")!), Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/10.jpg")!)], date: today, isDone: true, routine: .everyWeek),
            //            Housework(id: 43, place: "화장실", title: "변기 청소", member: [Member(id: 2, name: "이영희", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/5.jpg")!)], date: yesterday, isDone: false, routine: .biweek),
            //            Housework(id: 44, place: "베란다", title: "창문 닦기", member: [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/1.jpg")!), Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/45.jpg")!)], date: tomorrow, isDone: false, routine: .everyMonth),
            //            Housework(id: 45, place: "주방", title: "냉장고 정리", member: [Member(id: 3, name: "박민수", profileImageUrl: URL(string: "https://randomuser.me/api/portraits/men/53.jpg")!)], date: today, isDone: true, routine: .none)
        ]
    }()
    
    func getHaveHousework(from: Date, to: Date) async throws -> [Date: Bool] {
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
    
    func getHouseworkList(_ date: Date) async throws -> (myHouseworksLeft: [Housework], ourHouseworksLeft: [Housework], myHouseworksCompleted: [Housework], ourHouseworksCompleted: [Housework]) {
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
    
    func completeHousework(_ housework: Housework) async throws {
        dump("Completed housework: \(housework.title)")
    }
    
    func addHousework(_ housework: Housework) async throws {
        dump("Added housework: \(housework.title)")
    }
    
    func deleteHousework(_ housework: Housework) async throws {
        dump("Deleted housework: \(housework.title)")
    }
    
    func getHouseworkDetail(id: Int) async throws -> HouseworkDetail {
        let members = [Member(id: 1, name: "김철수", profileImageUrl: URL(string: "https://example.com/1.png")!)]
        return HouseworkDetail(id: id, title: "샘플 집안일", tags: ["정리"], date: Date(), members: members)
    }
    
    func getMyRecentHousework(receiverId: Int) async throws -> [RecentHouseworkDay] {
        let today = Calendar.current.startOfDay(for: Date())
        let items = [RecentHouseworkItem(id: 100, name: "청소", placeName: "거실"), RecentHouseworkItem(id: 101, name: "설거지", placeName: "주방")]
        return [RecentHouseworkDay(date: today, items: items)]
    }
    
    func getTodayPlaceHousework(placeId: Int) async throws -> TodayPlaceHousework {
        let urls = [URL(string: "https://example.com/1.png")!, URL(string: "https://example.com/2.png")!]
        return TodayPlaceHousework(my: [TodayHouseworkItem(id: 1, title: "서랍 정리", memberProfileImageUrls: urls)], our: [TodayHouseworkItem(id: 2, title: "바닥 청소", memberProfileImageUrls: urls)])
    }
}
