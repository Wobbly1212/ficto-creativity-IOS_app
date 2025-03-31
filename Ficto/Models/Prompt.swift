//
//  Prompt.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 09/12/24.
//

import Foundation

/// Represents a writing prompt in the app.
struct Prompt: Identifiable, Codable {
    let id: UUID                // Unique identifier for each prompt
    let text: String            // The prompt text
    let category: PromptCategory // Category for filtering prompts (e.g., creative, reflective)
    let language: Language       // Language of the prompt (e.g., English, Spanish, French)
    let createdAt: Date          // Date when the prompt was created

    /// Initializes a new prompt.
    init(id: UUID = UUID(), text: String, category: PromptCategory = .general, language: Language = .english, createdAt: Date = Date()) {
        self.id = id
        self.text = text
        self.category = category
        self.language = language
        self.createdAt = createdAt
    }
}

/// Categories for organizing prompts.
enum PromptCategory: String, Codable, CaseIterable, Identifiable {
    case general = "General"
    case creative = "Creative"
    case reflective = "Reflective"
    case motivational = "Motivational"

    var id: String { rawValue }
}

/// Supported languages for prompts.
enum Language: String, Codable, CaseIterable, Identifiable {
    case english = "English"
    case spanish = "Spanish"
    case french = "French"

    var id: String { rawValue }
}
