//
//  HistoryViewModel.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import Foundation

/// Manages the history of saved writings.
class HistoryViewModel: ObservableObject {
    @Published var writings: [Writing] = []        // List of saved writings
    @Published var selectedWriting: Writing?       // Currently selected writing for detailed view
    @Published var searchQuery: String = ""        // For searching through saved writings

    static let shared = HistoryViewModel()         // Singleton instance for shared access

    internal init() {
        loadWritings()
    }

    /// Adds a new writing to the history and saves it persistently.
    func addWriting(_ writing: Writing) {
        writings.append(writing)
        saveWritings()
    }

    /// Deletes a writing from the history and updates persistence.
    func deleteWriting(_ writing: Writing) {
        writings.removeAll { $0.id == writing.id }
        saveWritings()
    }

    /// Selects a specific writing for detailed view.
    func selectWriting(_ writing: Writing) {
        selectedWriting = writing
    }

    /// Updates an existing writing and saves changes.
    func updateWriting(_ updatedWriting: Writing) {
        if let index = writings.firstIndex(where: { $0.id == updatedWriting.id }) {
            writings[index] = updatedWriting
            saveWritings()
        }
    }

    /// Clears all saved writings and updates persistence.
    func clearAllWritings() {
        writings.removeAll()
        saveWritings()
    }

    /// Filters writings based on search query.
    var filteredWritings: [Writing] {
        if searchQuery.isEmpty {
            return writings
        } else {
            return writings.filter { $0.content.localizedCaseInsensitiveContains(searchQuery) }
        }
    }

    /// Saves writings to persistent storage using UserDefaults.
    private func saveWritings() {
        do {
            let data = try JSONEncoder().encode(writings)
            UserDefaults.standard.set(data, forKey: "writings")
        } catch {
            print("⚠️ Failed to encode writings: \(error.localizedDescription)")
        }
    }

    /// Loads writings from persistent storage.
    private func loadWritings() {
        if let data = UserDefaults.standard.data(forKey: "writings") {
            do {
                let savedWritings = try JSONDecoder().decode([Writing].self, from: data)
                self.writings = savedWritings
            } catch {
                print("⚠️ Failed to decode writings: \(error.localizedDescription)")
            }
        } else {
            print("ℹ️ No saved writings found.")
        }
    }
}
