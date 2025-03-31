//
//  WritingDetailView.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

struct WritingDetailView: View {
    @ObservedObject var viewModel: WritingDetailViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isEditing = false
    @State private var showDeleteConfirmation = false

    var body: some View {
        ZStack {
            // Background
            AnimatedBackgroundTabs()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            ScrollView {
                VStack(spacing: 20) {
                    // MARK: - Writing Header
                    VStack(alignment: .leading, spacing: 10) {
                        Text(viewModel.localizedString(forKey: "prompt"))
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.7))
                        
                        Text(viewModel.writing.prompt)
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 5)
                        
                        Text(viewModel.formattedDate)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.3)))
                    .padding(.horizontal)

                    // MARK: - Writing Content
                    VStack(alignment: .leading, spacing: 10) {
                        if isEditing {
                            TextEditor(text: $viewModel.editingText)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                                .shadow(radius: 5)
                                .foregroundColor(.black)
                        } else {
                            Text(viewModel.writing.content)
                                .font(.body)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding()
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.3)))
                    .padding(.horizontal)

                    // MARK: - AI Feedback
                    if viewModel.aiFeedbackEnabled {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(viewModel.localizedString(forKey: "ai_feedback"))
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text(viewModel.aiFeedback)
                                .font(.body)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding()
                        }
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.3)))
                        .padding(.horizontal)
                    }

                    // MARK: - Actions
                    HStack {
                        Button(action: { isEditing.toggle() }) {
                            Text(isEditing ? viewModel.localizedString(forKey: "Save") : viewModel.localizedString(forKey: "Edit"))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .accessibilityLabel(viewModel.localizedString(forKey: isEditing ? "save_button" : "edit_button"))
                        .accessibilityHint(viewModel.localizedString(forKey: isEditing ? "save_hint" : "edit_hint"))

                        Button(action: { showDeleteConfirmation = true }) {
                            Text(viewModel.localizedString(forKey: "Delete"))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .accessibilityLabel(viewModel.localizedString(forKey: "delete_button"))
                        .accessibilityHint(viewModel.localizedString(forKey: "delete_hint"))
                        .alert(isPresented: $showDeleteConfirmation) {
                            Alert(
                                title: Text(viewModel.localizedString(forKey: "delete_confirmation")),
                                message: Text(viewModel.localizedString(forKey: "delete_confirmation_message")),
                                primaryButton: .destructive(Text(viewModel.localizedString(forKey: "delete"))) {
                                    viewModel.deleteWriting()
                                    dismiss()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.localizedString(forKey: "Writing Detail"))
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            if isEditing {
                viewModel.saveChanges()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    WritingDetailView(viewModel: WritingDetailViewModel(writing: Writing(id: UUID(), prompt: "Sample Prompt", content: "Sample content", date: Date())))
}
