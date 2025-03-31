//
//  HistoryView.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: HistoryViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // Background
            AnimatedBackgroundTabs()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            VStack(alignment: .leading) {  // Aligned VStack to the left
                // Title
                Text("History")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.leading)  // Add padding to align it to the left
                    .accessibilityLabel("Writing History")
                    .accessibilityHint("Displays your past writings")

                if viewModel.writings.isEmpty {
                    Text("No writings yet.")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                        .padding()
                        .accessibilityLabel("No Writings Available")
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(viewModel.writings) { writing in
                                NavigationLink(destination: WritingDetailView(viewModel: WritingDetailViewModel(writing: writing))) {
                                    HistoryCardView(writing: writing)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: .infinity)  // Makes the ScrollView fill the available screen space
                }

                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - History Card View
struct HistoryCardView: View {
    var writing: Writing

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(writing.prompt)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(2)
                .truncationMode(.tail)

            Text(writing.content)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
                .lineLimit(3)
                .truncationMode(.tail)

            Text(writing.date, style: .date)
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.2))
                .shadow(radius: 5)
        )
        .padding(.vertical, 5)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Writing Entry")
        .accessibilityHint("Tap to view full content")
    }
}

// MARK: - Preview
#Preview {
    HistoryView(viewModel: HistoryViewModel.shared)
}
