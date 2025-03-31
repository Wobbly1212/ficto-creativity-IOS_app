//
//  FeedbackTemplates.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import Foundation

// MARK: - FeedbackCategory Enum
enum FeedbackCategory: String, Codable {
    case grammar         // Feedback related to grammar and syntax
    case style           // Feedback related to writing style
    case structure       // Feedback related to structure and flow
    case creativity      // Feedback related to creativity and ideas
    case engagement      // Feedback on user engagement and readability
}

// MARK: - FeedbackTemplate Model
struct FeedbackTemplate: Identifiable, Codable {
    var id = UUID()                 // Unique identifier for each template
    let category: FeedbackCategory  // Feedback category type
    let title: String               // Title for the feedback
    let template: String            // Template text with placeholders
}

// MARK: - Sample Feedback Templates
extension FeedbackTemplate {
    static let sampleTemplates: [FeedbackTemplate] = [
        FeedbackTemplate(
            category: .grammar,
            title: "Grammar Improvement",
            template: "Your writing is engaging, but I noticed some grammar issues. For example, consider revising: \"{example}\" to \"{correction}\" for clarity."
        ),
        FeedbackTemplate(
            category: .style,
            title: "Style Enhancement",
            template: "Your writing style is strong, but using more active voice could enhance it. For instance: \"{example}\" might flow better as \"{suggestion}\"."
        ),
        FeedbackTemplate(
            category: .structure,
            title: "Structural Advice",
            template: "Your ideas are well-presented. To improve the flow, consider reorganizing the paragraph starting with \"{example}\"."
        ),
        FeedbackTemplate(
            category: .creativity,
            title: "Boost Creativity",
            template: "Great idea! To make it more compelling, you might expand on the concept of \"{concept}\" with more descriptive language."
        ),
        FeedbackTemplate(
            category: .engagement,
            title: "Increase Engagement",
            template: "Your introduction is interesting! To hook readers even more, consider starting with a question or a bold statement: \"{suggestion}\"."
        )
    ]
}

// MARK: - FeedbackTemplateService
class FeedbackTemplateService {
    private var templates: [FeedbackTemplate] = FeedbackTemplate.sampleTemplates
    
    // Fetch templates by category
    func getTemplates(for category: FeedbackCategory) -> [FeedbackTemplate] {
        return templates.filter { $0.category == category }
    }
    
    // Fetch all templates
    func getAllTemplates() -> [FeedbackTemplate] {
        return templates
    }
    
    // Replace placeholders in templates
    func generateFeedback(from template: FeedbackTemplate, withReplacements replacements: [String: String]) -> String {
        var feedback = template.template
        for (placeholder, replacement) in replacements {
            feedback = feedback.replacingOccurrences(of: "{\(placeholder)}", with: replacement)
        }
        return feedback
    }
}

// MARK: - Testing Feedback Templates
struct FeedbackTemplateTester {
    static func run() {
        let service = FeedbackTemplateService()
        let grammarTemplate = service.getTemplates(for: .grammar).first!
        
        let generatedFeedback = service.generateFeedback(
            from: grammarTemplate,
            withReplacements: [
                "example": "He go to the store.",
                "correction": "He goes to the store."
            ]
        )
        
        print("✅ Generated Feedback: \(generatedFeedback)")
    }
}

