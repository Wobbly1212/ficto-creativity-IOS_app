//
//  WritingSessionView.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

struct WritingSessionView: View {
    @ObservedObject var viewModel: WritingSessionViewModel
    @State private var isSaved = false
    @State private var isTimerActive = false
    @State private var remainingTime: Int = 90 // Default 1:30 minutes
    @State private var showTimerSelector = false
    @State private var showPlayButton = true   // To show/hide the play button
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // MARK: - Animated Background
            AnimatedBackgroundTabs()
                .ignoresSafeArea()
                .accessibilityHidden(true)

            ScrollView {
                Spacer()
                Spacer()
                Spacer()
                VStack(spacing: 20) {
                    // MARK: - Prompt Display
                    VStack(spacing: 10) {
                        Spacer()
                        Spacer()
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.2))
                                .frame(minHeight: 120, maxHeight: 150)
                                .shadow(radius: 10)

                            VStack {
                                // Always show the prompt, but with a blur effect if the play button hasn't been tapped
                                Text(viewModel.prompt?.text ?? viewModel.localizedString(forKey: "no_prompt"))
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(5)
                                    .minimumScaleFactor(0.7)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.horizontal, 16)
                                    .blur(radius: showPlayButton ? 10 : 0) // Blur effect before play button is tapped
                                    .animation(.easeInOut, value: showPlayButton)
                            }
                        }
                    }
                    .padding(.horizontal)

                    // MARK: - Writing Area
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .shadow(radius: 10)

                        TextEditor(text: $viewModel.writingText)
                            .padding()
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .lineSpacing(6)
                    }
                    .frame(height: 250)
                    .padding(.horizontal)

                    Spacer()

                    // MARK: - Play Button and Timer Display
                    VStack(spacing: 20) {
                        if showPlayButton {
                            Button(action: {
                                showPlayButton = false
                                startTimer()
                            }) {
                                Image(systemName: "play.circle.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.white)
                            }
                        } else {
                            // Display the timer after tapping the play button
                            Text(timeString(from: remainingTime))
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }

                    Spacer()

                    // MARK: - Save and Cancel Buttons
                    HStack(spacing: 20) {
                        Button(action: {
                            viewModel.saveWriting()
                            isSaved = true
                        }) {
                            Text(viewModel.localizedString(forKey: "Done"))
                                .frame(maxWidth: 120)
                                .padding()
                                .background(Color.indigo)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.localizedString(forKey: "Writing Session"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            setupNavigationBarAppearance()
        }
        .alert(isPresented: $isSaved) {
            Alert(
                title: Text(viewModel.localizedString(forKey: "Saved")),
                message: Text(viewModel.localizedString(forKey: "Writing Saved.")),
                dismissButton: .default(Text("OK")) {
                    dismiss()
                }
            )
        }
    }

    // MARK: - Helper Methods
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func startTimer() {
        isTimerActive = true
        viewModel.revealPrompt()

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                isTimerActive = false
                timer.invalidate()
            }
        }
    }

    // MARK: - Customize Navigation Bar Appearance
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]  // Change title text color
  //      appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]  // Change large title text color
   //     appearance.backgroundColor = UIColor.systemIndigo  // Change background color

        UINavigationBar.appearance().standardAppearance = appearance
  //      UINavigationBar.appearance().scrollEdgeAppearance = appearance
    //    UINavigationBar.appearance().compactAppearance = appearance
    }
}

#Preview {
    WritingSessionView(viewModel: WritingSessionViewModel())
}
