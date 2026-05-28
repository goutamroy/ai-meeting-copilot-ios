//
//  AIMeetingCopilotTests.swift
//  AIMeetingCopilotTests
//
//  Created by Goutam Roy on 15/05/26.
//

import XCTest
@testable import AIMeetingCopilot

final class AIMeetingCopilotTests: XCTestCase {
    
    func testAppConfigBaseURLExists() {
        XCTAssertFalse(
            AppConfig.baseURL.isEmpty,
            "Base URL should not be empty"
        )
    }
}
