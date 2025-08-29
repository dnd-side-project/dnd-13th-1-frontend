import Foundation

public protocol CreateGroupUseCase: Sendable {
    func execute(backGroundTypeNum: Int) async throws -> GroupInfo
}
