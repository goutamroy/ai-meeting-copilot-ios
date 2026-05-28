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
        
        let data = try XCTUnwrap(
            json.data(using: .utf8)
        )
        
        let response = try JSONDecoder().decode(
            ChatResponse.self,
            from: data
        )
        
        XCTAssertEqual(
            response.answer,
            "Meeting was completed successfully"
        )
    }
    
    func testChatRequestEncoding() throws {
        
        let request = ChatRequest(
            question: "What was discussed?"
        )
        
        let data = try JSONEncoder().encode(
            request
        )
        
        let decoded = try JSONDecoder().decode(
            ChatRequest.self,
            from: data
        )
        
        XCTAssertEqual(
            decoded.question,
            "What was discussed?"
        )
    }
}
