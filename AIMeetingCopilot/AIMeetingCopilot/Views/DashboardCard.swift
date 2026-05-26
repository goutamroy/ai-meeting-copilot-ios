//
//  DashboardCard.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 14/05/26.
//

import SwiftUI

struct DashboardCard: View {
    
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            // Icon Section
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            
            // Text Section
            VStack(alignment: .leading, spacing: 6) {
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .lineLimit(2)
            }
            
            Spacer()
            
            
            // Arrow Section
            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 130)
        .background(
            LinearGradient(
                colors: [
                    color,
                    color.opacity(0.8)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(24)
        .shadow(
            color: color.opacity(0.25),
            radius: 10,
            x: 0,
            y: 6
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        DashboardCard(
            title: "Record Meeting",
            subtitle: "Capture and summarize meetings",
            icon: "mic.fill",
            color: .blue
        )
        
        DashboardCard(
            title: "Ask AI",
            subtitle: "Search previous meetings instantly",
            icon: "message.fill",
            color: .purple
        )
    }
    .padding()
}
