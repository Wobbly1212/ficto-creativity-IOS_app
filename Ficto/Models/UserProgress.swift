//
//  UserProgress.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import Foundation

/// Model to track user progress and achievements.
struct UserProgress: Codable {
    var points: Int = 0
    var badges: [String] = []
    var completedPrompts: Int = 0

    /// Provides a default instance of UserProgress.
    static func defaultProgress() -> UserProgress {
        return UserProgress()
    }
}
