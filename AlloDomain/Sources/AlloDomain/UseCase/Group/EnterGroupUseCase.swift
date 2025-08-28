import Foundation

public protocol EnterGroupUseCase: Sendable {
    func execute(inviteCode: String) async throws -> GroupInfo
}
