import Foundation

public protocol LogoutUseCase: Sendable {
    func execute() async throws
}
