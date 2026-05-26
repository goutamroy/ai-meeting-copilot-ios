//
//  AudioRecorderService.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 14/05/26.
//

import Foundation
import AVFoundation
import Combine
import os

final class AudioRecorderService: NSObject, ObservableObject {
    
    @Published var isRecording = false
    @Published var recordedFileURL: URL?
    @Published var recordingTime: TimeInterval = 0
    @Published var permissionDenied = false
    
    private var audioRecorder: AVAudioRecorder?
    private var timer: Timer?
    
    override init() {
        super.init()
        requestPermission()
    }
    
    
    // MARK: Request Permission
    private func requestPermission() {
        
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission {
                [weak self] allowed in
                
                DispatchQueue.main.async {
                    
                    guard let self else {
                        return
                    }
                    
                    if allowed {
                        AppLogger.recording.info(
                            "Microphone permission granted"
                        )
                    } else {
                        self.permissionDenied = true
                        
                        AppLogger.recording.error(
                            "Microphone permission denied"
                        )
                    }
                }
            }
            
        } else {
            
            AVAudioSession.sharedInstance()
                .requestRecordPermission {
                    [weak self] allowed in
                    
                    DispatchQueue.main.async {
                        
                        guard let self else {
                            return
                        }
                        
                        if allowed {
                            AppLogger.recording.info(
                                "Microphone permission granted"
                            )
                        } else {
                            self.permissionDenied = true
                            
                            AppLogger.recording.error(
                                "Microphone permission denied"
                            )
                        }
                    }
                }
        }
    }
    
    
    // MARK: Start Recording
    func startRecording() {
        
        guard !permissionDenied else {
            AppLogger.recording.error(
                "Recording blocked due to permission denial"
            )
            return
        }
        
        do {
            
            recordedFileURL = nil
            recordingTime = 0
            
            let session =
            AVAudioSession.sharedInstance()
            
            try session.setCategory(
                .playAndRecord,
                mode: .default
            )
            
            try session.setActive(true)
            
            let fileName =
            UUID().uuidString + ".m4a"
            
            let documentsDirectory =
            FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first
            
            guard let documentsDirectory else {
                throw AppError.recordingFailed
            }
            
            let fileURL =
            documentsDirectory
                .appendingPathComponent(
                    fileName
                )
            
            let settings:
            [String: Any] = [
                AVFormatIDKey:
                    Int(
                        kAudioFormatMPEG4AAC
                    ),
                
                AVSampleRateKey:
                    12000,
                
                AVNumberOfChannelsKey:
                    1,
                
                AVEncoderAudioQualityKey:
                    AVAudioQuality.high.rawValue
            ]
            
            audioRecorder =
            try AVAudioRecorder(
                url: fileURL,
                settings: settings
            )
            
            audioRecorder?
                .prepareToRecord()
            
            let success =
            audioRecorder?
                .record() ?? false
            
            if success {
                
                recordedFileURL =
                fileURL
                
                isRecording = true
                
                startTimer()
                
                AppLogger.recording.info(
                    "Recording started successfully"
                )
                
            } else {
                throw AppError.recordingFailed
            }
            
        } catch {
            
            AppLogger.recording.error(
                "Recording failed: \(error.localizedDescription)"
            )
        }
    }
    
    
    // MARK: Stop Recording
    func stopRecording() {
        
        audioRecorder?.stop()
        audioRecorder = nil
        
        isRecording = false
        
        stopTimer()
        
        AppLogger.recording.info(
            "Recording stopped successfully"
        )
    }
    
    
    // MARK: Start Timer
    private func startTimer() {
        
        timer?.invalidate()
        
        timer =
        Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { [weak self] _ in
            
            DispatchQueue.main.async {
                self?.recordingTime += 1
            }
        }
    }
    
    
    // MARK: Stop Timer
    private func stopTimer() {
        
        timer?.invalidate()
        timer = nil
    }
}
