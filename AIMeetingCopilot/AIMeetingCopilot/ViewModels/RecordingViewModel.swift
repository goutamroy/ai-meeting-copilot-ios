//
//  RecordingViewModel.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 14/05/26.
//

import Foundation
import Combine
import os

@MainActor
final class RecordingViewModel: ObservableObject {
    
    @Published var uploadResponse: UploadResponse?
    @Published var isUploading = false
    
    func uploadRecording(
        fileURL: URL
    ) async {
        
        isUploading = true
        
        do {
            let response = try await UploadService.shared
                .uploadAudio(fileURL: fileURL)
            
            uploadResponse = response
            AppStorageManager.shared.hasUploadedMeeting = true
            AppStorageManager.shared.lastMeetingId = response.meeting_id
            
            AppLogger.upload.info(
                "Upload completed successfully"
            )
            
        } catch {
            AppLogger.upload.error(
                "Upload failed: \(error.localizedDescription)"
            )
        }
        
        isUploading = false
    }
}
