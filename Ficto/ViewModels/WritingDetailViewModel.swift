//
//  WritingDetailViewModel.swift
//  Inkspire
//
//  Created by Mehdi Javdaneh on 11/03/25.
//


import Foundation

/// ViewModel to manage the details of a writing piece in the WritingDetailView.
class WritingDetailViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var writing: Writing
    @Published var editingText: String = ""
    @Published var aiFeedback: String = ""
    
    // Flags for certain functionalities
    @Published var isEditing: Bool = false
    var aiFeedbackEnabled: Bool = true

    // Reference to language service for localization
    private let languageService: LanguageService
    
    // MARK: - Computed Properties
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: writing.date)
    }
    
    // MARK: - Initializer
    init(writing: Writing, languageService: LanguageService = LanguageService.shared) {
        self.writing = writing
        self.languageService = languageService
        self.editingText = writing.content
        self.generateAIFeedback() // Assuming you generate feedback when initializing
    }
    
    // MARK: - Methods
    /// Localizes the provided key for the current language.
    func localizedString(forKey key: String) -> String {
        return languageService.localizedString(forKey: key) // Simplified to avoid extra argument
    }
    
    /// Toggle editing mode and update content if saved.
    func toggleEditing() {
        isEditing.toggle()
        if !isEditing {
            saveChanges()
        }
    }
    
    /// Save changes made to the writing content.
    func saveChanges() {
            writing.content = editingText // This should work
        }
    
    /// Generate AI feedback for the current writing.
    func generateAIFeedback() {
        // Example: Here you can call a service or logic that generates AI feedback
        aiFeedback = "This is a mock AI feedback based on the current content. Improve coherence and consider reworking the third paragraph."
        // Replace this with real AI feedback generation
    }
    
    /// Delete the current writing.
    func deleteWriting() {
        // Example: Here you could call a storage service to remove the writing from storage.
        // For now, it just resets the model's writing content.
        print("Writing deleted") // Debug statement
    }
}
