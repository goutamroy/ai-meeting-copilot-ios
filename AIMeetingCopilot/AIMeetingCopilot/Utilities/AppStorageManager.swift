//
//  AppStorageManager.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 15/05/26.
//

import Foundation

final class AppStorageManager {
    
    static let shared = AppStorageManager()
    
    private init() {}
    
    private let uploadedKey = "hasUploadedMeeting"
    private let meetingKey = "lastMeetingId"
    
    var hasUploadedMeeting: Bool {
        get {
            UserDefaults.standard.bool(
                forKey: uploadedKey
            )
        }
        set {
            UserDefaults.standard.set(
                newValue,
                forKey: uploadedKey
            )
        }
    }
    
    var lastMeetingId: Int {
        get {
            UserDefaults.standard.integer(
                forKey: meetingKey
            )
        }
        set {
            UserDefaults.standard.set(
                newValue,
                forKey: meetingKey
            )
        }
    }
}
