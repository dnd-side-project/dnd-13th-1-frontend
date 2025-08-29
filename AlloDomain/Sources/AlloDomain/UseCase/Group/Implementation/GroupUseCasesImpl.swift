import Foundation

final class CreateGroupUseCaseImpl: CreateGroupUseCase {
    private let repo: GroupRepository
    init(repo: GroupRepository) { self.repo = repo }
    func execute(backGroundTypeNum: Int) async throws -> GroupInfo {
        try await repo.createGroup(backGroundTypeNum: backGroundTypeNum)
    }
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

final class SetMyGroupUseCaseImpl: SetMyGroupUseCase {
    private let repo: GroupRepository
    init(repo: GroupRepository) { self.repo = repo }
    func execute(groupId: Int) { repo.setMyGroup(groupId: groupId) }
}
