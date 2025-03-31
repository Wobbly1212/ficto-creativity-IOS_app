//
//  SettingsView.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 09/12/24.
//

import SwiftUI

/// A view for managing app settings like language, dark mode, notifications, and AI feedback.
struct SettingsView: View {
    @ObservedObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                AnimatedBackgroundTabs()
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
                
                Form {
                    // MARK: - Language Selection
                    Section {
                        NavigationLink(destination: LanguageSelectorView(viewModel: viewModel)) {
                            HStack {
                                Text(viewModel.localizedString(forKey: "Select Language"))
                                    .foregroundColor(.white)  // Set text color to white
                                Spacer()
                                Text(viewModel.selectedLanguage.displayName)  // Use selectedLanguage from ViewModel
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                        .listRowBackground(Color.indigo.opacity(0.3))  // Indigo background for "Select Language"
                    }
                    
                    // MARK: - Appearance
                    Section {
                        customToggle(text: viewModel.localizedString(forKey: "Dark Mode"), isOn: $viewModel.isDarkModeEnabled)
                    }
                    
                    // MARK: - Notifications
                    Section {
                        customToggle(text: viewModel.localizedString(forKey: "Enable Notifications"), isOn: $viewModel.notificationsEnabled)
                    }
                    
                    // MARK: - AI Feedback
                   
                }
                .scrollContentBackground(.hidden)  // Prevents white background
                .navigationTitle(viewModel.localizedString(forKey: "Settings"))
                .foregroundColor(.red)  // Adjust this if needed
                .padding(.vertical)  // Adjust padding
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Helper for Custom Toggle
    func customToggle(text: String, isOn: Binding<Bool>) -> some View {
        Toggle(text, isOn: isOn)
            .toggleStyle(SwitchToggleStyle(tint: Color.indigo))  // Custom white toggle color
            .foregroundColor(.white)  // Toggle text color
            .listRowBackground(Color.indigo.opacity(0.3))  // Indigo background for sections
    }
}

// MARK: - Preview
#Preview {
    SettingsView()
}
