//
//  MeetingViewModel.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 13/05/26.
//

import Foundation
import Combine
import os

@MainActor
final class MeetingViewModel: ObservableObject {
    
    @Published var question = ""
    @Published var messages: [ChatMessage] = []
    @Published var isLoading = false
    
    func askQuestion() async {
        
        let trimmedQuestion = question.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        guard !trimmedQuestion.isEmpty else {
            return
        }
        
        let userMessage = ChatMessage(
            text: trimmedQuestion,
            isUser: true
        )
        
        messages.append(userMessage)
        
        let currentQuestion = trimmedQuestion
        question = ""
        
        isLoading = true
        
        do {
            let response = try await APIService.shared.askQuestion(
                question: currentQuestion,
                meetingId: String(AppStorageManager.shared.lastMeetingId)
            )
            
            let aiMessage = ChatMessage(
                text: response.answer,
                isUser: false
            )
            
            messages.append(aiMessage)
            
        } catch {
            
            let errorMessage = ChatMessage(
                text: "Something went wrong. Please try again.",
                isUser: false
            )
            
            messages.append(errorMessage)
            
            AppLogger.network.error(
                "Chat error: \(error.localizedDescription)"
            )
        }
        
        isLoading = false
    }
}
