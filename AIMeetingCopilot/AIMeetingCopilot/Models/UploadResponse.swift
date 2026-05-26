//
//  UploadResponse.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 14/05/26.
//

import Foundation

struct UploadResponse: Codable {
    let success: Bool
    let meeting_id: Int
    let db_persisted: Bool?
    let message: String
    let transcript: String
    let summary: String
    let action_items: String?
    let key_decisions: String?
}
