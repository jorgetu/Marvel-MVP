//
//  UILabelTests.swift
//  Marvel-MVPTests
//
//  Created by Jorge Arias Brasa on 13/02/2021.
//

import XCTest
@testable import Marvel_MVP

class UILabelTests: XCTestCase {

    // MARK: - Variables
    var label: UILabel!

    // MARK: - Lifecycle Methods
    override func setUp() {
        super.setUp()

        label = UILabel()
    }

    // MARK: - Tests
    func test_localizedText() {

        XCTAssertEqual(label.localizedText, "")
        label.localizedText = "comicList_title"
        XCTAssertEqual(label.text, "Marvel")
        XCTAssertEqual(label.localizedText, "Marvel")
    }
}
