//
//  LanguageSelectorView.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

struct LanguageSelectorView: View {
    @ObservedObject var viewModel: SettingsViewModel  // Use SettingsViewModel directly
    
    var body: some View {
        ZStack {
            // Background
            AnimatedBackgroundTabs()
                .ignoresSafeArea()
                .accessibilityHidden(true)

            VStack(spacing: 30) {
                // Title aligned to the left
                Spacer()

                // Language Options as buttons
                VStack(spacing: 20) {
                    LanguageOptionButton(language: .english, viewModel: viewModel)
                    LanguageOptionButton(language: .spanish, viewModel: viewModel)
                    LanguageOptionButton(language: .french, viewModel: viewModel)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
    }
}

struct LanguageOptionButton: View {
    let language: LanguageService.Language
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        Button(action: {
            viewModel.updateLanguage(to: language)  // Update language directly via ViewModel
        }) {
            Text(language.displayName)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(viewModel.selectedLanguage == language ? Color.indigo : Color.white.opacity(0.2)) // Indigo background for selected language
                .cornerRadius(12)
                .shadow(radius: 5)
        }
        .accessibilityLabel("\(language.displayName) Language Option")
        .accessibilityHint("Selects \(language.displayName) as the app's language")
        .padding(.horizontal, 30)
    }
}

// MARK: - Preview
#Preview {
    LanguageSelectorView(viewModel: SettingsViewModel())
}
