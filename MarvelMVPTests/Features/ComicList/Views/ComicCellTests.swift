//
//  ComicCellTests.swift
//  Marvel-MVPTests
//
//  Created by Jorge Arias Brasa on 13/02/2021.
//

import XCTest
@testable import Marvel_MVP

class ComicCellTests: XCTestCase {

    // MARK: - Variables
    var cell: ComicCell!

    var date: Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 2019
        components.month = 10
        components.day = 14
        return calendar.date(from: components)!
    }

    override func setUp() {
        super.setUp()

        cell = ComicCell.instantiate()
    }

    // MARK: - Tests
    func test_prepareForReuse() {

        cell.prepareForReuse()

        XCTAssertNil(cell.comicImage.image)
        XCTAssertNil(cell.comicTitle.text)
    }

    func test_bind_increased() {

        let comic = Comic(title: "Title One", issueNumber: 1, description: "Description", format: .comic, pageCount: 200, thumbnail: URL(string: "http://www.example.com/image.jpg"), printPrice: 30.0, digitalPrice: 20.0, onSaleDate: "28/12/2020")
        cell.bind(with: comic)

        XCTAssertEqual(cell.comicTitle.text, "Title One")
        XCTAssertFalse(cell.comicTitle.isHidden)
        XCTAssertFalse(cell.comicImage.isHidden)
//        let image = UIImage(named: "increased",
//                            in: Bundle.core,
//                            compatibleWith: nil)
//        XCTAssertNotNil(cell.stateImageView.image)
//        XCTAssertEqual(cell.stateImageView.image, image)
    }

    
    func test_bind_nil() {

        cell.bind(with: nil)

        XCTAssertTrue(cell.comicTitle.isHidden)
        XCTAssertTrue(cell.comicImage.isHidden)
        
    }
}
