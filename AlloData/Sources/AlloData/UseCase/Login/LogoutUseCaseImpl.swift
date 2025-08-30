import Foundation
import AlloDomain

public final class LogoutUseCaseImpl: LogoutUseCase {
    
    public func execute() async throws {
        try KeychainService.delete(key: "accessToken")
        UserDefaultsService.isSignedIn = false
    }
}
