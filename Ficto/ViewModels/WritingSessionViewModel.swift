//
//  WritingSessionViewModel.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//


import Foundation
import Combine

/// ViewModel to manage the writing session and related operations.

class WritingSessionViewModel: ObservableObject {
    @Published var writingText: String = ""              // User's current writing content
    @Published var prompt: Prompt?                       // The current prompt for the session
    @Published var isPromptRevealed: Bool = false        // Controls prompt visibility based on timer status
    @Published var feedback: String = ""                 // AI feedback for the writing
    @Published var isFeedbackVisible: Bool = false       // Controls visibility of AI feedback
    private let promptViewModel = PromptViewModel()      // Internal instance of PromptViewModel
    private let feedbackService = FeedbackService()      // AI feedback generator
    private var cancellable = Set<AnyCancellable>()           // To store Combine subscription
    
    init() {
        self.prompt = promptViewModel.currentPrompt
        isPromptRevealed = false  // Ensure prompt is hidden initially
    }

    /// Fetches a new random prompt for the session.
    func randomizePrompt() {
        promptViewModel.selectRandomPrompt()
        self.prompt = promptViewModel.currentPrompt
        isPromptRevealed = false  // Hide prompt initially after randomizing
        isFeedbackVisible = false // Hide feedback for new prompt
        feedback = ""             // Clear previous feedback
    }
    
    

    /// Saves the user's writing to the history and triggers AI feedback.
    func saveWriting() {
        guard let prompt = prompt, !writingText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let newWriting = Writing(
            id: UUID(),               // Generate a unique identifier
            prompt: prompt.text,      // Use the current prompt's text
            content: writingText,     // Use the user-provided writing content
            date: Date()              // Use the current date
        )
        HistoryViewModel.shared.addWriting(newWriting)
        // Trigger feedback generation
        generateFeedback(for: newWriting)
        writingText = ""             // Clear the text after saving
    }

    /// Triggers AI-based feedback for the writing session.
    private func generateFeedback(for writing: Writing) {
        feedbackService.generateFeedback(for: writing.content)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("❌ Feedback generation error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] feedbackText in
                self?.feedback = feedbackText
                self?.isFeedbackVisible = true
            }
            .store(in: &cancellable)// Store the subscription
    }

    /// Clears the current writing session.
    func clearSession() {
        writingText = ""
        randomizePrompt()            // Fetch a new prompt after clearing
        isPromptRevealed = false     // Ensure prompt is hidden initially
        isFeedbackVisible = false    // Hide feedback after clearing
    }

    /// Reveals the prompt when the timer starts.
    func revealPrompt() {
        isPromptRevealed = true  // Reveal prompt when timer starts
    }
    func localizedString(forKey key: String) -> String {
           return NSLocalizedString(key, comment: "")
       }
}
