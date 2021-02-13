//
//  WebServiceTests.swift
//  Marvel-MVPTests
//
//  Created by Jorge Arias Brasa on 13/02/2021.
//

import XCTest
@testable import Marvel_MVP


// MARK: - URLSessionDataTaskMock
class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    override func resume() {
        closure()
    }
}

// MARK: - URLSessionMock
class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?

    init(configuration: URLSessionConfiguration? = nil) {}

    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}

// MARK: - WebServiceTests
class WebServiceTests: XCTestCase {

    // MARK: - Constants
    private enum Constants {
        static let baseURL: URL = URL(string: "www.test.com")!
        static let offset: Int = 20
        static let startsWith: String = "text"
    }

    // MARK: - Variables
    var session: URLSessionMock!
    var webService: WebService!

    // MARK: - Lifecycle Methods
    override func setUp() {
        super.setUp()

        session = URLSessionMock()
        webService = WebService(session: session)
    }

    // MARK: - Tests
    func test_load_failure_01() {

        let error = NSError(domain: "domain", code: 000, userInfo: nil)
        session.error = error

        var serviceError: ServiceError?
        webService.load(ComicListServiceResponse.self,
                        from: .comics(offset: Constants.offset, titleStartsWith: Constants.startsWith)) { result in

            switch result {
            case .success:
                serviceError = nil
            case .failure(let error):
                serviceError = error
            }
        }

        if let serviceError = serviceError {
            XCTAssert(serviceError.errorDescription == ServiceError.unexpected.errorDescription)
        } else {
            XCTFail("WebService call expected to fail and succeeded")
        }
    }

    func test_load_failure_02() {

        var serviceError: ServiceError?
        webService.load(ComicListServiceResponse.self,
                        from: .comics(offset: Constants.offset, titleStartsWith: Constants.startsWith)) { result in

            switch result {
            case .success:
                serviceError = nil
            case .failure(let error):
                serviceError = error
            }
        }

        if let serviceError = serviceError {
            XCTAssert(serviceError.errorDescription == ServiceError.internalServer.errorDescription)
        } else {
            XCTFail("WebService call expected to fail and succeeded")
        }
    }

    func test_load_failure_03() {

        let response = HTTPURLResponse(url: Constants.baseURL,
                                       statusCode: 409,
                                       httpVersion: nil,
                                       headerFields: nil)
        session.response = response

        var serviceError: ServiceError?
        webService.load(ComicListServiceResponse.self,
                        from: .comics(offset: Constants.offset, titleStartsWith: Constants.startsWith)) { result in

            switch result {
            case .success:
                serviceError = nil
            case .failure(let error):
                serviceError = error
            }
        }

        if let serviceError = serviceError {
            XCTAssert(serviceError.errorDescription == ServiceError.business.errorDescription)
        } else {
            XCTFail("WebService call expected to fail and succeeded")
        }
    }

    func test_load_failure_04() {

        let response = HTTPURLResponse(url: Constants.baseURL,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        session.response = response

        var serviceError: ServiceError?
        webService.load(ComicListServiceResponse.self,
                        from: .comics(offset: Constants.offset, titleStartsWith: Constants.startsWith)) { result in

            switch result {
            case .success:
                serviceError = nil
            case .failure(let error):
                serviceError = error
            }
        }

        if let serviceError = serviceError {
            XCTAssert(serviceError.errorDescription == ServiceError.noContent.errorDescription)
        } else {
            XCTFail("WebService call expected to fail and succeeded")
        }
    }

    func test_load_failure_05() {

        let response = HTTPURLResponse(url: Constants.baseURL,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        session.response = response
        session.data = Data()

        var serviceError: ServiceError?
        webService.load(ComicListServiceResponse.self,
                        from: .comics(offset: Constants.offset, titleStartsWith: Constants.startsWith)) { result in

            switch result {
            case .success:
                serviceError = nil
            case .failure(let error):
                serviceError = error
            }
        }

        if let serviceError = serviceError {
            XCTAssert(serviceError.errorDescription == ServiceError.mappingFailed.errorDescription)
        } else {
            XCTFail("WebService call expected to fail and succeeded")
        }
    }

    func test_load_success() {

        let response = HTTPURLResponse(url: Constants.baseURL,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        session.response = response

        let comics = ComicListServiceResponse(code: nil, status: nil, copyright: nil, attributionText: nil, attributionHTML: nil, etag: nil, data: nil)
        let encoder = JSONEncoder()
        let data = try? encoder.encode(comics)

        session.data = data

        var succeeded = false
        webService.load(ComicListServiceResponse.self,
                        from: .comics(offset: Constants.offset, titleStartsWith: Constants.startsWith)) { result in

            switch result {
            case .success:
                succeeded = true
            case .failure:
                succeeded = false
            }
        }

        XCTAssertTrue(succeeded)
    }
}
