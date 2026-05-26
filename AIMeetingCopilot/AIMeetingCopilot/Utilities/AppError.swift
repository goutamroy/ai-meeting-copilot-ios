//
//  AppError.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 15/05/26.
//

import Foundation

enum AppError: LocalizedError {
    
    case uploadFailed
    case recordingFailed
    case invalidURL
    
    var errorDescription: String? {
        switch self {
        case .uploadFailed:
            return "Upload failed."
        case .recordingFailed:
            return "Recording failed."
        case .invalidURL:
            return "Invalid URL."
        }
    }
}
