import Foundation

public protocol GetMyGroupUseCase: Sendable {
    func execute() async throws -> GroupInfo
}
