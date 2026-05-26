//
//  APIService.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 13/05/26.
//

import Foundation
import os

class APIService {
    
    static let shared = APIService()
    
    private let baseURL = AppConfig.baseURL
    
    func askQuestion(
        question: String,
        meetingId: String
    ) async throws -> ChatResponse {
        
        guard let url = URL(
            string: "\(AppConfig.baseURL)/chat"
        ) else {
            throw AppError.invalidURL
        }
        
        let requestBody: [String: Any] = [
            "question": question,
            "meeting_id": meetingId
        ]
        
        let jsonData = try JSONSerialization.data(
            withJSONObject: requestBody
        )
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        // Use your existing logger correctly
        AppLogger.network.info(
            "Sending chat request"
        )
        
        let (data, response) = try await URLSession.shared.data(
            for: request
        )
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AppError.uploadFailed
        }
        
        AppLogger.network.info(
            "Chat response received"
        )
        
        guard httpResponse.statusCode == 200 else {
            throw AppError.uploadFailed
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(
                ChatResponse.self,
                from: data
            )
            
            return decodedResponse
            
        } catch {
            AppLogger.network.error(
                "Chat decoding failed"
            )
            
            throw AppError.uploadFailed
        }
    }
}
