//
//  String.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

public extension String {

    enum Constants {
        static let bundleIdentifierBase: String = "com.jab.marvel-mvp"
        static let apiKey: String = "bfd889df37e22e319fa732c9fe437d4b"
        static let privateKey: String = "f287e8fc84a9702c32ae83cc4d21ed2d0ecee2f2"
        static let ts: String = "123456789"
        static let hash: String = "4e8ffd7de6cd223497351eca95a8dc02"
    }

    // MARK: - String + localized
    var localized: String {

        var bundle: Bundle?
        if let bundleName = self.split(separator: "_").first {
            if bundleName == "app" {
                bundle = .main
            } else {
                bundle = Bundle(identifier: "\(Constants.bundleIdentifierBase).\(bundleName)")
            }
        }

        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: bundle ?? .main,
                                 value: "**\(self)**",
                                 comment: "")
    }
}


