import Foundation

public protocol FetchTagsUseCase: Sendable { func execute() async throws -> [TagItem] }
public protocol AddTagUseCase: Sendable { func execute(name: String) async throws -> TagItem }

final class FetchTagsUseCaseImpl: FetchTagsUseCase { private let repo: TagRepository; init(repo: TagRepository){ self.repo = repo } ; func execute() async throws -> [TagItem] { try await repo.fetchTags() } }
final class AddTagUseCaseImpl: AddTagUseCase { private let repo: TagRepository; init(repo: TagRepository){ self.repo = repo } ; func execute(name: String) async throws -> TagItem { try await repo.addTag(name: name) } }


