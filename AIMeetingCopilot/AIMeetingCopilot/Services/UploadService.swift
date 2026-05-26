//
//  UploadService.swift
//  AIMeetingCopilot
//
//  Created by Goutam Roy on 13/05/26.
//

import Foundation
import os
import UniformTypeIdentifiers

final class UploadService {
    
    static let shared = UploadService()
    
    private init() {}
    
    func uploadAudio(fileURL: URL) async throws -> UploadResponse {
        
        guard let url = URL(
            string: "\(AppConfig.baseURL)/upload"
        ) else {
            throw AppError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        
        request.setValue(
            "multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type"
        )
        
        let audioData = try Data(contentsOf: fileURL)
        
        let fileName = fileURL.lastPathComponent
        let fileExtension = fileURL.pathExtension
        
        let mimeType = getMimeType(
            fileExtension: fileExtension
        )
        
        var body = Data()
        
        // Opening boundary
        if let openingBoundary = "--\(boundary)\r\n"
            .data(using: .utf8) {
            body.append(openingBoundary)
        } else {
            throw AppError.uploadFailed
        }
        
        // Content disposition
        if let contentDisposition = """
            Content-Disposition: form-data; name="file"; filename="\(fileName)"\r\n
            """.data(using: .utf8) {
            body.append(contentDisposition)
        } else {
            throw AppError.uploadFailed
        }
        
        // Dynamic MIME type
        if let contentType = """
            Content-Type: \(mimeType)\r\n\r\n
            """.data(using: .utf8) {
            body.append(contentType)
        } else {
            throw AppError.uploadFailed
        }
        
        // Audio file data
        body.append(audioData)
        
        // Closing boundary
        if let closingBoundary = "\r\n--\(boundary)--\r\n"
            .data(using: .utf8) {
            body.append(closingBoundary)
        } else {
            throw AppError.uploadFailed
        }
        
        do {
            let (data, response) = try await URLSession.shared.upload(
                for: request,
                from: body
            )
            
            if let httpResponse = response as? HTTPURLResponse {
                AppLogger.upload.info(
                    "Upload response status: \(httpResponse.statusCode)"
                )
            }
            
            if let rawJSON = String(data: data, encoding: .utf8) {
                AppLogger.upload.info("Raw upload response: \(rawJSON)")
            }
            
            let decodedResponse = try JSONDecoder().decode(
                UploadResponse.self,
                from: data
            )
            
            AppLogger.upload.info(
                "Upload completed successfully"
            )
            
            return decodedResponse
            
        } catch {
            AppLogger.upload.error(
                "Upload failed: \(error.localizedDescription)"
            )
            
            throw AppError.uploadFailed
        }
    }
    
    
    // MARK: Dynamic MIME Type
    private func getMimeType(
        fileExtension: String
    ) -> String {
        
        if let utType = UTType(
            filenameExtension: fileExtension
        ),
           let mimeType = utType.preferredMIMEType {
            return mimeType
        }
        
        return "application/octet-stream"
    }
}
