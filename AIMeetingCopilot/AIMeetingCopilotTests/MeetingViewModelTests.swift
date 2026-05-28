//
//  MeetingViewModelTests.swift
//  AIMeetingCopilotTests
//
//  Created by Goutam Roy on 15/05/26.
//

import XCTest
@testable import AIMeetingCopilot

@MainActor
final class MeetingViewModelTests: XCTestCase {
    
    func testInitialMessagesEmpty() {
        
        let viewModel = MeetingViewModel()
        
        XCTAssertTrue(
            viewModel.messages.isEmpty
        )
    }
    
    func testInitialQuestionEmpty() {
        
        let viewModel = MeetingViewModel()
        
        XCTAssertEqual(
            viewModel.question,
            ""
        )
    }
    
    func testLoadingInitiallyFalse() {
        
        let viewModel = MeetingViewModel()
        
        XCTAssertFalse(
            viewModel.isLoading
        )
    }
    
    func testChatMessageCreation() {
        
        let message = ChatMessage(
            text: "Hello AI",
            isUser: true
        )
        
        XCTAssertEqual(
            message.text,
            "Hello AI"
        )
        
        XCTAssertTrue(
            message.isUser
        )
    }
}
