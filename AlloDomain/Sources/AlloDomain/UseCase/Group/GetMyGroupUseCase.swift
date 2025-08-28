import Foundation

public protocol GetMyGroupUseCase {
    func execute() async throws -> GroupInfo
}


