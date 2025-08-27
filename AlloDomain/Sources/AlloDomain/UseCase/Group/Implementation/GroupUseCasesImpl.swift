import Foundation

final class CreateGroupUseCaseImpl: CreateGroupUseCase {
    private let repo: GroupRepository
    init(repo: GroupRepository) { self.repo = repo }
    func execute(characterId: Int) async throws -> GroupInfo { try await repo.createGroup(characterId: characterId) }
}

final class EnterGroupUseCaseImpl: EnterGroupUseCase {
    private let repo: GroupRepository
    init(repo: GroupRepository) { self.repo = repo }
    func execute(inviteCode: String) async throws -> GroupInfo { try await repo.enterGroup(inviteCode: inviteCode) }
}

final class GetMyGroupUseCaseImpl: GetMyGroupUseCase {
    private let repo: GroupRepository
    init(repo: GroupRepository) { self.repo = repo }
    func execute() async throws -> GroupInfo { try await repo.getMyGroup() }
}


