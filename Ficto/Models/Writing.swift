//
//  Writing.swift
//  Inkspire
//
//  Created by Hosein Darabi on 09/12/24.
//

import Foundation

/// Represents a user's writing entry associated with a prompt.
struct Writing: Codable, Identifiable {
    var id: UUID
    var prompt: String
    var content: String // It should be 'var' to allow modification
    var date: Date                 // Timestamp for when the writing was saved
    var feedback: String?            // AI-generated feedback for the writing
    var language: WritingLanguage    // Language used for this writing
    var pointsEarned: Int            // Points earned for completing this writing

    /// Initializes a new writing entry.
    init(id: UUID = UUID(),
         prompt: String,
         content: String,
         date: Date = Date(),
         feedback: String? = nil,
         language: WritingLanguage = .english,
         pointsEarned: Int = 0) {
        self.id = id
        self.prompt = prompt
        self.content = content
        self.date = date
        self.feedback = feedback
        self.language = language
        self.pointsEarned = pointsEarned
    }
}

/// Enum for supported languages in the app.
enum WritingLanguage: String, Codable, CaseIterable, Identifiable {
    case english = "English"
    case spanish = "Español"
    case french = "Français"

    var id: String { rawValue }
}
