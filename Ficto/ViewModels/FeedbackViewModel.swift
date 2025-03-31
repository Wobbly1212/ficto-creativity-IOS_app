//
//  FeedbackViewModel.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 09/12/24.
//

import Foundation
import Combine

/// Manages AI-based feedback for the user's writing.
class FeedbackViewModel: ObservableObject {
    @Published var feedback: String = ""         // Stores feedback text
    @Published var isLoading: Bool = false       // Loading state for AI feedback request
    @Published var errorMessage: String?         // Error message in case of failures
    private var cancellables = Set<AnyCancellable>() // Handles asynchronous operations
    
    private let feedbackService = FeedbackService()  // Instance of service handling AI requests

    /// Requests AI-generated feedback for the provided writing content.
    func requestFeedback(for content: String) {
        guard !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            feedback = "Please write something first to receive feedback."
            return
        }

        isLoading = true  // Start loading
        errorMessage = nil // Clear previous error messages

        feedbackService.generateFeedback(for: content)
            .receive(on: DispatchQueue.main)    // Ensure updates on main thread
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false        // Stop loading regardless of outcome
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.feedback = "⚠️ Failed to get feedback: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] aiFeedback in
                self?.feedback = aiFeedback    // Update feedback
            })
            .store(in: &cancellables)          // Store the subscription
    }

    /// Clears the feedback state.
    func clearFeedback() {
        feedback = ""
        errorMessage = nil
    }
}
