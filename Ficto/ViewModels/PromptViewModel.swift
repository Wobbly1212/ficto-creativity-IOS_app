//
//  PromptViewModel.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import Foundation

/// ViewModel to manage prompts and handle prompt-related operations.
class PromptViewModel: ObservableObject {
    @Published var prompts: [Prompt] = []       // List of loaded prompts
    @Published var currentPrompt: Prompt?       // Currently selected prompt
    @Published var isLoading: Bool = false      // Indicates if prompts are loading
    @Published var errorMessage: String?        // Stores error messages if loading fails

    init() {
        loadPrompts()
        selectRandomPrompt()
    }

    /// Loads prompts from a JSON file in the app bundle or falls back to default prompts.
    private func loadPrompts() {
        isLoading = true
        if let url = Bundle.main.url(forResource: "prompts", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                prompts = try decoder.decode([Prompt].self, from: data)
                print("✅ Prompts loaded from JSON: \(prompts.count) prompts.")
            } catch {
                print("❌ Failed to load prompts from JSON: \(error.localizedDescription)")
                useDefaultPrompts()
                errorMessage = "Failed to load prompts. Using default prompts instead."
            }
        } else {
            print("❌ prompts.json not found in bundle. Loading default prompts.")
            useDefaultPrompts()
            errorMessage = "Prompts file not found. Loaded default prompts."
        }
        isLoading = false
    }

    /// Selects a random prompt from the loaded list.
    func selectRandomPrompt() {
        guard !prompts.isEmpty else {
            print("❌ No prompts available. Loading default prompts.")
            useDefaultPrompts()
            return
        }
        currentPrompt = prompts.randomElement()
        print("✅ Selected prompt: \(currentPrompt?.text ?? "None")")
    }

    /// Adds a new prompt to the list.
    func addPrompt(_ newPrompt: Prompt) {
        prompts.append(newPrompt)
        savePrompts()
    }

    /// Saves prompts to persistent storage using UserDefaults.
    private func savePrompts() {
        do {
            let data = try JSONEncoder().encode(prompts)
            UserDefaults.standard.set(data, forKey: "prompts")
        } catch {
            print("⚠️ Failed to save prompts: \(error.localizedDescription)")
        }
    }

    /// Loads prompts from persistent storage if available.
    private func loadSavedPrompts() {
        if let data = UserDefaults.standard.data(forKey: "prompts") {
            do {
                let savedPrompts = try JSONDecoder().decode([Prompt].self, from: data)
                self.prompts = savedPrompts
            } catch {
                print("⚠️ Failed to load saved prompts: \(error.localizedDescription)")
            }
        } else {
            print("ℹ️ No saved prompts found.")
        }
    }

    /// Fallback default prompts if JSON fails to load.
    private func useDefaultPrompts() {
        prompts = [
            Prompt(id: UUID(), text: "The power went out for just a few minutes, but when the lights returned, the arrangement of your furniture had subtly changed."),
            Prompt(id: UUID(), text: "Your neighbor’s cat appeared at your door with a ribbon tied around its neck and a tiny brass key dangling from it."),
            Prompt(id: UUID(), text: "The daily news alert was normal until the last line, which read: 'If you’re reading this, stay inside.'"),
            Prompt(id: UUID(), text: "The streetlight outside your window flickered every night at the same time. Tonight, it stayed off for much longer than usual."),
            Prompt(id: UUID(), text: "You were sorting through your old photos when you noticed that in every group picture, there was someone standing in the background wearing the same red coat."),
            Prompt(id: UUID(), text: "You received a voicemail, but it was just the sound of someone breathing and the faint hum of an old song in the background."),
            Prompt(id: UUID(), text: "Your phone buzzed with a notification: 'Your package has been delivered.' But you hadn’t ordered anything."),
            Prompt(id: UUID(), text: "The corner of the park bench had initials carved into it, followed by the words: 'It begins here.'"),
            Prompt(id: UUID(), text: "Your friend asked you about a memory you don’t recall, but they were certain you were there."),
            Prompt(id: UUID(), text: "You found an old train ticket in your coat pocket with today’s date stamped on it, but you don’t remember ever buying it.")
        ]
        print("✅ Loaded default prompts: \(prompts.count) prompts available.")
    }
}
