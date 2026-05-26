//
//  ChatMessage.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 14/05/26.
//
import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}
