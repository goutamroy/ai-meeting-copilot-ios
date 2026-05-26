//
//  SummaryView.swift..swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 14/05/26.
//

import SwiftUI

struct SummaryView: View {
    
    let response: UploadResponse
    
    @State private var showFullTranscript = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    
                    Spacer()
                    
                    Text("Meeting Insights")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    Color.clear
                        .frame(width: 50)
                }
                .padding(.horizontal)
                
                // Transcript Card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Transcript")
                        .font(.title3)
                        .bold()
                    
                    let transcriptText = response.transcript
                    
                    Text(
                        showFullTranscript
                        ? transcriptText
                        : String(transcriptText.prefix(300))
                    )
                    .foregroundColor(.gray)
                    
                    if transcriptText.count > 300 {
                        Button(
                            showFullTranscript
                            ? "Show Less"
                            : "Show More"
                        ) {
                            showFullTranscript.toggle()
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                
                // Summary Card
                summaryCard(
                    title: "Summary",
                    content: extractSection("Summary")
                )
                
                summaryCard(
                    title: "Key Decisions",
                    content: extractSection("Key Decisions")
                )
                
                summaryCard(
                    title: "Action Items",
                    content: extractSection("Action Items")
                )
                
                NavigationLink {
                    ChatView(
                        meetingId: String(response.meeting_id)
                    )
                } label: {
                    Text("Ask AI")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func summaryCard(
        title: String,
        content: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3)
                .bold()
            
            Text(content)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
    
    private func extractSection(
        _ sectionTitle: String
    ) -> String {
        
        let summaryText = response.summary
        
        if summaryText.contains(sectionTitle) {
            return summaryText
        }
        
        return summaryText
    }
}
