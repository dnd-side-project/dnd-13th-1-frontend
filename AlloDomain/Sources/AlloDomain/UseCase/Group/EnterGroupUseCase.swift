import Foundation

public protocol EnterGroupUseCase {
    func execute(inviteCode: String) async throws -> GroupInfo
}


