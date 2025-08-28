import Foundation

public protocol CreateGroupUseCase {
    func execute(characterId: Int) async throws -> GroupInfo
}


