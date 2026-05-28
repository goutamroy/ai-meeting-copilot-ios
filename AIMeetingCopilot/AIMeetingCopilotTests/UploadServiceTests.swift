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
            "meeting_id": 123,
            "transcript": "test transcript",
            "summary": "test summary",
            "action_items": ["Task 1"],
            "key_decisions": ["Decision 1"]
        }
        """
        
        let data = try XCTUnwrap(
            json.data(using: .utf8)
        )
        
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
            123
        )
        
        XCTAssertEqual(
            response.transcript,
            "test transcript"
        )
        
        XCTAssertEqual(
            response.summary,
            "test summary"
        )
        
        XCTAssertEqual(
            response.action_items?.first as? String,
            "Task 1"
        )
        
        XCTAssertEqual(
            response.key_decisions?.first as? String,
            "Decision 1"
        )
    }
}
