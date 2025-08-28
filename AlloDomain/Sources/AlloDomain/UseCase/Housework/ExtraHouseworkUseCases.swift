import Foundation

public protocol GetHouseworkDetailUseCase { func execute(id: Int) async throws -> HouseworkDetail }
public protocol GetMyRecentHouseworkUseCase { func execute(receiverId: Int) async throws -> [RecentHouseworkDay] }
public protocol GetTodayPlaceHouseworkUseCase { func execute(placeId: Int) async throws -> TodayPlaceHousework }

final class GetHouseworkDetailUseCaseImpl: GetHouseworkDetailUseCase {
    private let repo: HouseworkRepository
    init(repo: HouseworkRepository) { self.repo = repo }
    func execute(id: Int) async throws -> HouseworkDetail { try await repo.getHouseworkDetail(id: id) }
}

final class GetMyRecentHouseworkUseCaseImpl: GetMyRecentHouseworkUseCase {
    private let repo: HouseworkRepository
    init(repo: HouseworkRepository) { self.repo = repo }
    func execute(receiverId: Int) async throws -> [RecentHouseworkDay] { try await repo.getMyRecentHousework(receiverId: receiverId) }
}

final class GetTodayPlaceHouseworkUseCaseImpl: GetTodayPlaceHouseworkUseCase {
    private let repo: HouseworkRepository
    init(repo: HouseworkRepository) { self.repo = repo }
    func execute(placeId: Int) async throws -> TodayPlaceHousework { try await repo.getTodayPlaceHousework(placeId: placeId) }
}


