//
//  WritingService.swift
//  Inkspire
//
//  Created by Mehdi Javdaneh on 11/03/25.
//


import Foundation

/// A service to manage saving and deleting writings.
class WritingService {
    static let shared = WritingService()

    private var writings: [Writing] = []

    private init() {}

    /// Update an existing writing.
    func updateWriting(_ writing: Writing) {
        if let index = writings.firstIndex(where: { $0.id == writing.id }) {
            writings[index] = writing
        }
    }

    /// Delete a writing.
    func deleteWriting(_ writing: Writing) {
        writings.removeAll { $0.id == writing.id }
    }

    /// Retrieve all writings (for future reference, if needed).
    func getAllWritings() -> [Writing] {
        return writings
    }
}