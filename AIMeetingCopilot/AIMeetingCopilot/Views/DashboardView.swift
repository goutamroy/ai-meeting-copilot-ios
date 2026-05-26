//
//  DashboardView.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 14/05/26.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var navigateToChat = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                Spacer()
                    .frame(height: 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(AppStrings.welcomeBack)
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    Text(AppStrings.appTitle)
                        .font(.largeTitle)
                        .bold()
                    
                    Text(AppStrings.meetingsProcessed)
                        .foregroundColor(.gray)
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                
                NavigationLink(
                    destination: RecordingView()
                ) {
                    DashboardCard(
                        title: AppStrings.recordMeeting,
                        subtitle: "Capture and summarize meetings",
                        icon: "mic.fill",
                        color: AppColors.primaryBlue
                    )
                }
                
                if AppStorageManager.shared.hasUploadedMeeting {
                    NavigationLink(
                        destination: ChatView(
                            meetingId: String(AppStorageManager.shared.lastMeetingId)
                        )
                    ) {
                        DashboardCard(
                            title: AppStrings.askAI,
                            subtitle: "Ask questions from past meeting",
                            icon: "message.fill",
                            color: AppColors.primaryPurple
                        )
                    }
                } else {
                    DashboardCard(
                        title: AppStrings.askAI,
                        subtitle: "Upload a meeting first",
                        icon: "message.fill",
                        color: AppColors.primaryPurple
                    )
                    .opacity(0.5)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}
