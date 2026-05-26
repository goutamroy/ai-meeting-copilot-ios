
//  ChatView.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 13/05/26.
//

import SwiftUI
import os

struct ChatView: View {
    
    let meetingId: String
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var messageText: String = ""
    @State private var messages: [ChatMessage] = []
    @State private var isLoading: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            
            headerView
            
            Divider()
            
            if messages.isEmpty {
                emptyStateView
            } else {
                chatContentView
            }
            
            Divider()
            
            inputView
        }
        .background(Color(.systemGray6))
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

// MARK: - Header View
extension ChatView {
    
    private var headerView: some View {
        HStack {
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            
            Spacer()
            
            Text("Ask AI")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            Color.clear
                .frame(width: 60, height: 60)
        }
        .padding(.horizontal)
        .padding(.top)
        .padding(.bottom, 20)
    }
}

// MARK: - Chat Content
extension ChatView {
    
    private var chatContentView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 16) {
                    
                    ForEach(messages) { message in
                        messageBubble(message)
                            .id(message.id)
                    }
                    
                    if isLoading {
                        loadingView
                    }
                    
                    Color.clear
                        .frame(height: 1)
                        .id("BOTTOM")
                }
                .padding()
            }
            .onChange(of: messages.count) { _, _ in
                scrollToBottom(proxy)
            }
            .onChange(of: isLoading) { _, _ in
                scrollToBottom(proxy)
            }
        }
    }
}

// MARK: - Empty State
extension ChatView {
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            Image(systemName: "message")
                .font(.system(size: 70))
                .foregroundColor(.gray.opacity(0.4))
            
            Text("Ask anything about your meeting")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            VStack(spacing: 12) {
                Text("Examples:")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                Text("• What was discussed?")
                Text("• What is the meeting time?")
                Text("• What are the action items?")
            }
            .foregroundColor(.gray.opacity(0.8))
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Input View
extension ChatView {
    
    private var inputView: some View {
        HStack(spacing: 12) {
            
            TextField(
                "Ask about your meeting...",
                text: $messageText
            )
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .keyboardType(.default)
            .disableAutocorrection(true)
            .submitLabel(.send)
            .focused($isTextFieldFocused)
            .padding(.horizontal, 16)
            .frame(height: 50)
            .background(Color.white)
            .cornerRadius(25)
            .onSubmit {
                sendMessage()
            }
            
            Button {
                sendMessage()
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .frame(width: 55, height: 55)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            .disabled(
                messageText
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .isEmpty || isLoading
            )
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color(.systemGray6))
    }
}

// MARK: - Loading View
extension ChatView {
    
    private var loadingView: some View {
        HStack {
            ProgressView()
            
            Text("AI is thinking...")
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

// MARK: - Message Bubble
extension ChatView {
    
    private func messageBubble(_ message: ChatMessage) -> some View {
        HStack {
            
            if message.isUser {
                Spacer(minLength: 50)
            }
            
            Text(message.text)
                .padding()
                .foregroundColor(
                    message.isUser ? .white : .black
                )
                .background(
                    message.isUser
                    ? Color.blue
                    : Color.gray.opacity(0.25)
                )
                .cornerRadius(20)
                .frame(
                    maxWidth: 280,
                    alignment: message.isUser ? .trailing : .leading
                )
            
            if !message.isUser {
                Spacer(minLength: 50)
            }
        }
    }
}

// MARK: - Functions
extension ChatView {
    
    private func sendMessage() {
        let trimmedMessage = messageText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        guard !trimmedMessage.isEmpty else { return }
        
        guard !meetingId.isEmpty else {
            messages.append(
                ChatMessage(
                    text: "No meeting found. Please upload a meeting first.",
                    isUser: false
                )
            )
            return
        }
        
        let userMessage = ChatMessage(
            text: trimmedMessage,
            isUser: true
        )
        
        messages.append(userMessage)
        
        messageText = ""
        isLoading = true
        
        isTextFieldFocused = false
        hideKeyboard()
        
        Task {
            do {
                let response = try await APIService.shared.askQuestion(
                    question: trimmedMessage,
                    meetingId: meetingId
                )
                
                let aiMessage = ChatMessage(
                    text: response.answer,
                    isUser: false
                )
                
                messages.append(aiMessage)
                
            } catch {
                AppLogger.network.error(
                    "Ask AI failed: \(error.localizedDescription)"
                )
                
                let errorMessage = ChatMessage(
                    text: "Something went wrong. Please try again.",
                    isUser: false
                )
                
                messages.append(errorMessage)
            }
            
            isLoading = false
        }
    }
    
    private func scrollToBottom(
        _ proxy: ScrollViewProxy
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                proxy.scrollTo(
                    "BOTTOM",
                    anchor: .bottom
                )
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
