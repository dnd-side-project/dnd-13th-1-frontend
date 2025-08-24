//
//  AIRepositoryImpl.swift
//  AlloData
//
//  Created by 김민솔 on 8/23/25.
//

import Foundation
import AlloDomain

final class AIRepositoryImpl: AIRepository {
    private let apiClient: AIAPIClient
    
    init(apiClient: AIAPIClient) {
        self.apiClient = apiClient
    }
    
    func transformText(_ text: String) async throws -> String {
        try await apiClient.callAITransformAPI(text: text)
    }
}


final class AIAPIClient {
    private let apiKey: String
    private let url: URL = URL(string: "https://api.openai.com/v1/chat/completions")!

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    public func callAITransformAPI(text: String) async throws -> String {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                ["role": "system", "content": "사용자의 문장을 다정한 말투로 변환해줘. 200자 이내로."],
                ["role": "user", "content": text]
            ],
            "temperature": 0.7,
            "max_tokens": 200
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        return decoded.choices.first?.message.content ?? text
    }
}

// MARK: - Response Model
struct OpenAIResponse: Codable {
    struct Choice: Codable {
        struct Message: Codable {
            let role: String
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}
