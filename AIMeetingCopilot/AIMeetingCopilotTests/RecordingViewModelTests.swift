//
//  RecordingViewModelTests.swift
//  AIMeetingCopilotTests
//
//  Created by Goutam Roy on 15/05/26.
//

import XCTest
@testable import AIMeetingCopilot

@MainActor
final class RecordingViewModelTests:
    XCTestCase {
    
    func testInitialState() {
        
        let viewModel =
        RecordingViewModel()
        
        XCTAssertNil(
            viewModel.uploadResponse
        )
        
        XCTAssertFalse(
            viewModel.isUploading
        )
    }
}
