//
//  ServiceErrorTests.swift
//  Marvel-MVPTests
//
//  Created by Jorge Arias Brasa on 13/02/2021.
//

import XCTest
@testable import Marvel_MVP

class ServiceErrorTests: XCTestCase {

    func test_errorDescription() {

        var errorDescription: String
        errorDescription = "Could not decode response as desired type"
        XCTAssert(ServiceError.mappingFailed.errorDescription == errorDescription)
        errorDescription = "An error has occurred"
        XCTAssert(ServiceError.unexpected.errorDescription == errorDescription)
        errorDescription = "An error has occurred"
        XCTAssert(ServiceError.business.errorDescription == errorDescription)
        errorDescription = "The device has no connection to the internet"
        XCTAssert(ServiceError.noNetwork.errorDescription == errorDescription)
        errorDescription = "The connection received an invalid server response"
        XCTAssert(ServiceError.internalServer.errorDescription == errorDescription)
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
        errorDescription = "Unknown error"
        XCTAssert(ServiceError.unknown(error: error).errorDescription == errorDescription)
        errorDescription = "The connection timed out"
        XCTAssert(ServiceError.timedOut.errorDescription == errorDescription)
        errorDescription = "The connection retrieved no response"
        XCTAssert(ServiceError.noContent.errorDescription == errorDescription)
    }

    func test_mapServiceError() {

        var error: NSError
        var description: String?
        error = NSError(domain: "", code: 000)
        description = ServiceError.unexpected.errorDescription
        XCTAssert(ServiceError.mapServiceError(error: error).errorDescription == description)
        error = NSError(domain: "", code: 001)
        description = ServiceError.noNetwork.errorDescription
        XCTAssert(ServiceError.mapServiceError(error: error).errorDescription == description)
        error = NSError(domain: "", code: -60)
        description = ServiceError.noNetwork.errorDescription
        XCTAssert(ServiceError.mapServiceError(error: error).errorDescription == description)
        error = NSError(domain: "", code: -1009)
        description = ServiceError.noNetwork.errorDescription
        XCTAssert(ServiceError.mapServiceError(error: error).errorDescription == description)
        error = NSError(domain: "", code: 409)
        description = ServiceError.business.errorDescription
        XCTAssert(ServiceError.mapServiceError(error: error).errorDescription == description)
        error = NSError(domain: "", code: 500)
        description = ServiceError.internalServer.errorDescription
        XCTAssert(ServiceError.mapServiceError(error: error).errorDescription == description)
        error = NSError(domain: "", code: -1011)
        description = ServiceError.internalServer.errorDescription
        XCTAssert(ServiceError.mapServiceError(error: error).errorDescription == description)
        error = NSError(domain: "", code: -998, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
        description = ServiceError.unknown(error: error).errorDescription
        XCTAssert(ServiceError.mapServiceError(error: error).errorDescription == description)
        error = NSError(domain: "", code: -1001)
        description = ServiceError.timedOut.errorDescription
        XCTAssert(ServiceError.mapServiceError(error: error).errorDescription == description)
        error = NSError(domain: "", code: -1014)
        description = ServiceError.noContent.errorDescription
        XCTAssert(ServiceError.mapServiceError(error: error).errorDescription == description)
        error = NSError(domain: "", code: 9999999, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
        description = ServiceError.unknown(error: error).errorDescription
        XCTAssert(ServiceError.mapServiceError(error: error).errorDescription == description)
    }
}
