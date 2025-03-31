//
//  CircularTimerSelector.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

struct CircularTimerSelector: View {
    @Binding var showTimerSelector: Bool
    @Binding var selectedDuration: Int
    var startTimerCallback: (Int) -> Void

    let timerOptions: [Int] = [180, 300, 600] // 3 min, 5 min, 10 min

    var body: some View {
        VStack(spacing: 20) {
            Text("Select Timer Duration")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .accessibilityLabel("Timer Duration Selector")
                .accessibilityHint("Choose a duration for the timer")

            // Timer Options
            timerOptionsView()

            // Start Button
            startButton()

            // Cancel Button
            cancelButton()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.8))
                .shadow(radius: 10)
        )
        .padding(.horizontal, 40)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Timer Selection Menu")
        .accessibilityHint("Select a time duration and start the timer")
    }

    /// Displays the available timer options as buttons.
    @ViewBuilder
    private func timerOptionsView() -> some View {
        HStack(spacing: 20) {
            ForEach(timerOptions, id: \.self) { duration in
                TimerOptionButton(label: "\(duration / 60) min", duration: duration, selectedDuration: $selectedDuration)
            }
        }
        .padding()
    }

    /// A start button that triggers the startTimerCallback.
    @ViewBuilder
    private func startButton() -> some View {
        Button(action: {
            showTimerSelector = false
            startTimerCallback(selectedDuration)
        }) {
            Text("Start Timer")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green.gradient)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.horizontal)
        .accessibilityLabel("Start Timer")
        .accessibilityHint("Starts the timer with the selected duration")
    }

    /// A cancel button that closes the timer selector.
    @ViewBuilder
    private func cancelButton() -> some View {
        Button(action: {
            showTimerSelector = false
        }) {
            Text("Cancel")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red.gradient)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.horizontal)
        .accessibilityLabel("Cancel Timer Selection")
        .accessibilityHint("Closes the timer selector without starting a timer")
    }
}

// MARK: - Timer Option Button
struct TimerOptionButton: View {
    let label: String
    let duration: Int
    @Binding var selectedDuration: Int

    var body: some View {
        Button(action: {
            selectedDuration = duration
        }) {
            timerButtonContent()
        }
        .accessibilityLabel("\(label) Button")
        .accessibilityHint("Sets the timer duration to \(label)")
        .accessibilityValue(selectedDuration == duration ? "Selected" : "Not selected")
    }

    /// A helper method for button content.
    @ViewBuilder
    private func timerButtonContent() -> some View {
        Text(label)
            .font(.subheadline)
            .frame(width: 80, height: 80)
            .background(
                Circle()
                    .fill(selectedDuration == duration ? Color.blue : Color.gray.opacity(0.2))
            )
            .foregroundColor(.white)
            .overlay(
                Circle()
                    .stroke(selectedDuration == duration ? Color.white : Color.clear, lineWidth: 3)
            )
            .shadow(radius: selectedDuration == duration ? 5 : 0)
    }
}

// MARK: - Preview
#Preview {
    CircularTimerSelector(showTimerSelector: .constant(true), selectedDuration: .constant(300)) { _ in }
}
