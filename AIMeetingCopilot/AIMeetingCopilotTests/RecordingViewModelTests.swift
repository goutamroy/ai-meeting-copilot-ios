//
//  RecordingViewModelTests.swift
//  AIMeetingCopilotTests
//
//  Created by Goutam Roy on 15/05/26.
//

import XCTest
@testable import AIMeetingCopilot

@MainActor
final class RecordingViewModelTests: XCTestCase {
    
    func testInitialState() {
        
        let viewModel = RecordingViewModel()
        
        XCTAssertNil(
            viewModel.uploadResponse
        )
        
        XCTAssertFalse(
            viewModel.isUploading
        )
    }
    
    func testUploadStateChanges() {
        
        let viewModel = RecordingViewModel()
        
        viewModel.isUploading = true
        
        XCTAssertTrue(
            viewModel.isUploading
        )
        
        viewModel.isUploading = false
        
        XCTAssertFalse(
            viewModel.isUploading
        )
    }
}
