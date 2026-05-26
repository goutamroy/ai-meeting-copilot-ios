//
//  APIServiceTests.swift
//  AIMeetingCopilotTests
//
//  Created by Goutam Roy on 15/05/26.
//

import XCTest
@testable import AIMeetingCopilot

@MainActor
final class APIServiceTests: XCTestCase {
    
    func testChatResponseDecoding() throws {
        
        let json = """
        {
            "answer": "Meeting was completed successfully"
        }
        """
        
        guard let data = json.data(
            using: .utf8
        ) else {
            XCTFail("Failed to create test data")
            return
        }
        
        let response = try JSONDecoder().decode(
            ChatResponse.self,
            from: data
        )
        
        XCTAssertEqual(
            response.answer,
            "Meeting was completed successfully"
        )
    }
}
