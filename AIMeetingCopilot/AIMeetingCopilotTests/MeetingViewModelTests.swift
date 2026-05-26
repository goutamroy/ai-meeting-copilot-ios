//
//  MeetingViewModelTests.swift
//  AIMeetingCopilotTests
//
//  Created by Goutam Roy on 15/05/26.
//

import XCTest
@testable import AIMeetingCopilot

@MainActor
final class MeetingViewModelTests:
    XCTestCase {
    
    func testInitialMessagesEmpty() {
        
        let viewModel =
        MeetingViewModel()
        
        XCTAssertTrue(
            viewModel.messages.isEmpty
        )
    }
    
    func testInitialQuestionEmpty() {
        
        let viewModel =
        MeetingViewModel()
        
        XCTAssertEqual(
            viewModel.question,
            ""
        )
    }
}
