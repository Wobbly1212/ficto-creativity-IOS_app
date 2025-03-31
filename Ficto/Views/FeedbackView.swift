//
//  FeedbackView.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

struct FeedbackView: View {
    @ObservedObject var viewModel: FeedbackViewModel  // Observing the view model

    var body: some View {
        VStack {
            // Text Field for input (you can bind this to a user input if needed)
            TextField("Enter your text", text: .constant("Your input here"))
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // Button to trigger the feedback request
            Button(action: {
                // Example: Request feedback for some sample content
                viewModel.requestFeedback(for: "Sample writing content.")
            }) {
                Text("Get Feedback")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            // Display feedback or loading indicator
            if viewModel.isLoading {
                ProgressView("Loading feedback...")
                    .padding()
            } else {
                // Display feedback text from the ViewModel
                ScrollView {
                    Text(viewModel.feedback)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.body)
                }
            }

            // Display error message if any
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
}

// MARK: - Preview
#Preview {
    FeedbackView(viewModel: FeedbackViewModel())
}
