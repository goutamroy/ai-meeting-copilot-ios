//
//  AppLogger.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 15/05/26.
//

import Foundation
import OSLog

struct AppLogger {
    
    static let recording = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "",
        category: "Recording"
    )
    
    static let network = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "",
        category: "Network"
    )
    
    static let upload = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "",
        category: "Upload"
    )
}
