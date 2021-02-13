//
//  EndPointTests.swift
//  Marvel-MVPTests
//
//  Created by Jorge Arias Brasa on 13/02/2021.
//

import XCTest
@testable import Marvel_MVP

class EndPointTests: XCTestCase {

    // MARK: - Constants
    private enum Constants {
        static let baseURL: URL = URL(string: "www.test.com")!
        static let offset: Int = 20
        static let startsWith: String = "text"
    }

    // MARK: - Tests
    func test_comics() {

        let endpoint: Endpoint = .comics(offset: Constants.offset, titleStartsWith: Constants.startsWith)
        let request = endpoint.request(with: Constants.baseURL, adding: [:])
        XCTAssertNotNil(request)
        XCTAssertEqual(request.url?.path, "www.test.com/comics")
        XCTAssertEqual(request.httpMethod, "GET")

        if let absoluteString = request.url?.absoluteString,
            let components = URLComponents(string: absoluteString) {

            var parameter = components.queryItems?.first { $0.name == "offset" }?.value
            XCTAssertEqual(parameter, "\(Constants.offset)")
            parameter = components.queryItems?.first { $0.name == "titleStartsWith" }?.value
            XCTAssertEqual(parameter, Constants.startsWith)
        }
    }

//    func test_current() {
//
//        let endpoint: Endpoint = .current
//        let request = endpoint.request(with: Constants.baseURL, adding: [:])
//        XCTAssertNotNil(request)
//        XCTAssertEqual(request.url?.path, "www.test.com/currentprice.json")
//        XCTAssertEqual(request.httpMethod, "GET")
//    }
}
