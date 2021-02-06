//
//  String.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

public extension String {

    private enum Constants {
        static let bundleIdentifierBase: String = "com.jab.marvel-mvp"
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


