//
//  RecordingView.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 14/05/26.
//

import SwiftUI

struct RecordingView: View {
    
    @StateObject private var recorderService = AudioRecorderService()
    @StateObject private var viewModel = RecordingViewModel()
    
    @State private var showUploadError = false
    @State private var uploadErrorMessage = ""
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 30) {
                
                Spacer()
                
                // MARK: Recording Icon
                Image(
                    systemName: recorderService.isRecording
                    ? "waveform.circle.fill"
                    : "mic.circle.fill"
                )
                .font(.system(size: 110))
                .foregroundColor(
                    recorderService.isRecording
                    ? AppColors.dangerRed
                    : AppColors.primaryBlue
                )
                
                
                // MARK: Recording Status
                Text(
                    recorderService.isRecording
                    ? AppStrings.recordingInProgress
                    : (
                        recorderService.recordedFileURL != nil
                        ? AppStrings.recordingCompleted
                        : AppStrings.readyToRecord
                    )
                )
                .font(.title3)
                .foregroundColor(.gray)
                
                
                // MARK: Recording Timer
                if recorderService.isRecording {
                    Text(
                        formatTime(
                            recorderService.recordingTime
                        )
                    )
                    .font(.title2)
                    .bold()
                    .foregroundColor(
                        AppColors.dangerRed
                    )
                }
                
                
                // MARK: Permission Error
                if recorderService.permissionDenied {
                    Text("Microphone permission required")
                        .foregroundColor(
                            AppColors.dangerRed
                        )
                        .font(.headline)
                        .multilineTextAlignment(
                            .center
                        )
                }
                
                
                // MARK: Record Button
                Button {
                    if recorderService.isRecording {
                        recorderService.stopRecording()
                    } else {
                        recorderService.startRecording()
                    }
                } label: {
                    HStack {
                        
                        Image(
                            systemName:
                                recorderService.isRecording
                            ? "stop.fill"
                            : "mic.fill"
                        )
                        
                        Text(
                            recorderService.isRecording
                            ? AppStrings.stopRecording
                            : AppStrings.startRecording
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        recorderService.isRecording
                        ? AppColors.dangerRed
                        : AppColors.primaryBlue
                    )
                    .foregroundColor(.white)
                    .cornerRadius(16)
                }
                .disabled(
                    recorderService.permissionDenied
                )
                
                
                // MARK: Upload Button
                Button {
                    Task {
                        if let fileURL =
                            recorderService.recordedFileURL {
                            
                            await viewModel.uploadRecording(
                                fileURL: fileURL
                            )
                            
                            if viewModel.uploadResponse == nil {
                                uploadErrorMessage =
                                "Upload failed. Please try again."
                                
                                showUploadError = true
                            }
                        }
                    }
                } label: {
                    Text(
                        AppStrings.uploadToAI
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        AppColors.successGreen
                    )
                    .foregroundColor(.white)
                    .cornerRadius(16)
                }
                .disabled(
                    recorderService.recordedFileURL == nil ||
                    recorderService.isRecording ||
                    viewModel.isUploading ||
                    recorderService.permissionDenied
                )
                
                Spacer()
            }
            .padding()
            .navigationTitle(
                AppStrings.recordMeeting
            )
            
            
            // MARK: Navigate to Summary Screen
            .navigationDestination(
                isPresented: Binding(
                    get: {
                        viewModel.uploadResponse != nil
                    },
                    set: { _ in }
                )
            ) {
                if let response =
                    viewModel.uploadResponse {
                    SummaryView(
                        response: response
                    )
                }
            }
            
            
            // MARK: Processing Loader
            .fullScreenCover(
                isPresented:
                    $viewModel.isUploading
            ) {
                ProcessingView()
            }
            
            
            // MARK: Upload Retry Alert
            .alert(
                "Upload Failed",
                isPresented:
                    $showUploadError
            ) {
                
                Button("Retry") {
                    if let fileURL =
                        recorderService.recordedFileURL {
                        
                        Task {
                            await viewModel.uploadRecording(
                                fileURL: fileURL
                            )
                        }
                    }
                }
                
                Button(
                    "Cancel",
                    role: .cancel
                ) {}
                
            } message: {
                Text(uploadErrorMessage)
            }
        }
    }
    
    
    // MARK: Format Timer
    private func formatTime(
        _ time: TimeInterval
    ) -> String {
        
        let minutes =
        Int(time) / 60
        
        let seconds =
        Int(time) % 60
        
        return String(
            format: "%02d:%02d",
            minutes,
            seconds
        )
    }
}


#Preview {
    RecordingView()
}
