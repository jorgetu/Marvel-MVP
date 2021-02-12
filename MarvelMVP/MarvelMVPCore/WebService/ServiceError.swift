//
//  ServiceError.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

public enum ServiceError: LocalizedError {

    case mappingFailed
    case unexpected
    case noNetwork
    case business
    case internalServer
    case timedOut
    case noContent
    case unknown(error: NSError)

    // MARK: - Variables
    public var errorDescription: String? {
        switch self {
        case .mappingFailed:
            return "serviceError_mappingFailed".localized
        case .unexpected, .business:
            return "serviceError_unexpected".localized
        case .noNetwork:
            return "serviceError_noNetwork".localized
        case .internalServer:
            return "serviceError_internalServer".localized
        case .timedOut:
            return "serviceError_timedOut".localized
        case .noContent:
            return "serviceError_noContent".localized
        case .unknown(let error):
            return error.localizedDescription
        }
    }

    // MARK: - Internal Methods
    static func mapServiceError(error: NSError) -> ServiceError {

        switch error.code {
        case 000:
            return .unexpected
        case 001, -60, -1009:
            return .noNetwork
        case 409:
            return .business
        case 500, -1011:
            return .internalServer
        case -1001:
            return .timedOut
        case -1014:
            return .noContent
        default:
            return .unknown(error: error)
        }
    }
}
