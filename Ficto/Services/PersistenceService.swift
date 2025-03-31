//
//  PersistenceService.swift
//  Inkspire
//
//  Created by Hosein Darabi on 09/12/24.
//

import Foundation

/// Service to handle saving and loading of user data locally.
class PersistenceService {
    static let shared = PersistenceService()  // Singleton instance for shared access

    private let writingsKey = "writings"
    private let settingsKey = "userSettings"
    private let progressKey = "userProgress"

    private init() {}  // Private init to enforce singleton pattern

    // MARK: - Writing Persistence

    /// Saves writings to persistent storage.
    /// - Parameter writings: Array of `Writing` to save.
    func saveWritings(_ writings: [Writing]) {
        do {
            let data = try JSONEncoder().encode(writings)
            UserDefaults.standard.set(data, forKey: writingsKey)
        } catch {
            print("❌ Failed to encode writings: \(error.localizedDescription)")
        }
    }

    /// Loads writings from persistent storage.
    /// - Returns: Array of `Writing` or empty if none found.
    func loadWritings() -> [Writing] {
        guard let data = UserDefaults.standard.data(forKey: writingsKey) else { return [] }
        do {
            return try JSONDecoder().decode([Writing].self, from: data)
        } catch {
            print("❌ Failed to decode writings: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Settings Persistence

    /// Saves user settings to persistent storage.
    /// - Parameter settings: `UserSettings` object to save.
    func saveSettings(_ settings: UserSettings) {
        do {
            let data = try JSONEncoder().encode(settings)
            UserDefaults.standard.set(data, forKey: settingsKey)
        } catch {
            print("❌ Failed to encode settings: \(error.localizedDescription)")
        }
    }

    /// Loads user settings from persistent storage.
    /// - Returns: `UserSettings` or default settings if none found.
    func loadSettings() -> UserSettings {
        guard let data = UserDefaults.standard.data(forKey: settingsKey) else {
            return UserSettings.defaultSettings()
        }
        do {
            return try JSONDecoder().decode(UserSettings.self, from: data)
        } catch {
            print("❌ Failed to decode settings: \(error.localizedDescription)")
            return UserSettings.defaultSettings()
        }
    }

    // MARK: - User Progress Persistence

    /// Saves user progress data.
    /// - Parameter progress: `UserProgress` object to save.
    func saveProgress(_ progress: UserProgress) {
        do {
            let data = try JSONEncoder().encode(progress)
            UserDefaults.standard.set(data, forKey: progressKey)
        } catch {
            print("❌ Failed to encode progress: \(error.localizedDescription)")
        }
    }

    /// Loads user progress data.
    /// - Returns: `UserProgress` or default if none found.
    func loadProgress() -> UserProgress {
        guard let data = UserDefaults.standard.data(forKey: progressKey) else {
            return UserProgress()  // Return default progress
        }
        do {
            return try JSONDecoder().decode(UserProgress.self, from: data)
        } catch {
            print("❌ Failed to decode progress: \(error.localizedDescription)")
            return UserProgress()  // Return default progress
        }
    }
}
