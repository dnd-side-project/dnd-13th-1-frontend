import Foundation

public protocol SendEmotionCardUseCase { func execute(houseWorkId: Int, receiverId: Int, compliments: [String], disappointment: String?) async throws -> Int }
public protocol GetEmotionCardDetailUseCase { func execute(id: Int) async throws -> EmotionCard }
public protocol GetEmotionCardListUseCase { func execute(filter: String, sorted: String) async throws -> [EmotionCard] }

final class SendEmotionCardUseCaseImpl: SendEmotionCardUseCase {
    private let repo: EmotionRepository
    init(repo: EmotionRepository) { self.repo = repo }
    func execute(houseWorkId: Int, receiverId: Int, compliments: [String], disappointment: String?) async throws -> Int {
        try await repo.sendEmotionCard(houseWorkId: houseWorkId, receiverId: receiverId, compliments: compliments, disappointment: disappointment)
    }
}

final class GetEmotionCardDetailUseCaseImpl: GetEmotionCardDetailUseCase {
    private let repo: EmotionRepository
    init(repo: EmotionRepository) { self.repo = repo }
    func execute(id: Int) async throws -> EmotionCard { try await repo.fetchEmotionCardDetail(id: id) }
}

final class GetEmotionCardListUseCaseImpl: GetEmotionCardListUseCase {
    private let repo: EmotionRepository
    init(repo: EmotionRepository) { self.repo = repo }
    func execute(filter: String, sorted: String) async throws -> [EmotionCard] { try await repo.fetchEmotionCardList(filter: filter, sorted: sorted) }
}


