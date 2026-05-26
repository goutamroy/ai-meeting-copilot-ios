//
//  ProcessingView.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 14/05/26.
//

import SwiftUI

struct ProcessingView: View {
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(
                colors: [
                    AppColors.primaryBlue,
                    AppColors.primaryPurple
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                ProgressView()
                    .scaleEffect(2)
                    .tint(.white)
                
                Text(
                    AppStrings.processingMeeting
                )
                .font(.title2)
                .foregroundColor(.white)
            }
        }
    }
}
