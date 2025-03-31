//
//  FeedbackService.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 09/12/24.
//

import Foundation
import Combine

/// Service to provide AI-based feedback on user writings using the Cohere API.
class FeedbackService {
    private let apiKey = "YOUR_COHERE_API_KEY"  // Replace with your actual Cohere API key
    private let apiURL = "https://api.cohere.ai/v1/generate"

    /// Fetches AI feedback for the provided text.
    /// - Parameter text: User's written content.
    /// - Returns: A publisher that provides feedback string or error.
    func generateFeedback(for text: String) -> AnyPublisher<String, Error> {
        let prompt = """
        Please provide constructive feedback on the following writing, focusing on grammar, creativity, and clarity. 
        Also, suggest improvements to enhance the content:
        \(text)
        """

        return sendRequest(prompt: prompt, maxTokens: 150)
    }

    /// Fetches motivational quote based on user's progress.
    /// - Parameter points: User's current points.
    /// - Returns: A publisher that provides a quote string or error.
    func generateMotivationalQuote(for points: Int) -> AnyPublisher<String, Error> {
        let prompt = """
        Provide a motivational quote for a user who has earned \(points) points, encouraging them to continue writing:
        """

        return sendRequest(prompt: prompt, maxTokens: 60)
    }

    /// Sends a request to the Cohere API.
    /// - Parameters:
    ///   - prompt: The prompt text to send to the API.
    ///   - maxTokens: Maximum number of tokens to generate.
    /// - Returns: A publisher that provides a response or error.
    private func sendRequest(prompt: String, maxTokens: Int) -> AnyPublisher<String, Error> {
        guard let url = URL(string: apiURL) else {
            return Fail(error: NSError(domain: "Invalid URL", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "xlarge",
            "prompt": prompt,
            "max_tokens": maxTokens
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> String in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }

                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                guard let generations = json?["generations"] as? [[String: Any]],
                      let feedback = generations.first?["text"] as? String else {
                    throw NSError(domain: "Invalid JSON response", code: 0, userInfo: nil)
                }

                return feedback.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .eraseToAnyPublisher()
    }
}
