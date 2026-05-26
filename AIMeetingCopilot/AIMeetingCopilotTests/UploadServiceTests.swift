//
//  UploadServiceTests.swift
//  AIMeetingCopilotTests
//
//  Created by Goutam Roy on 15/05/26.
//

import XCTest
@testable import AIMeetingCopilot

@MainActor
final class UploadServiceTests: XCTestCase {
    
    func testUploadResponseDecoding() throws {
        
        let json = """
        {
            "message": "uploaded successfully",
            "blob_url": "test_url",
            "meeting_id": "123",
            "transcript": "test transcript",
            "summary": "test summary"
        }
        """
        
        guard let data = json.data(
            using: .utf8
        ) else {
            XCTFail("Failed to create test data")
            return
        }
        
        let response = try JSONDecoder().decode(
            UploadResponse.self,
            from: data
        )
        
        XCTAssertEqual(
            response.message,
            "uploaded successfully"
        )
        
        XCTAssertEqual(
            response.meeting_id,
            "123"
        )
    }
}
