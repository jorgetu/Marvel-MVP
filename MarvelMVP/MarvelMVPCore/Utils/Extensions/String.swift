//
//  String.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation
import CryptoKit

public extension String {

    enum Constants {
        static let bundleIdentifierBase: String = "com.jab.marvel-mvp"
        static let apiKey: String = "bfd889df37e22e319fa732c9fe437d4b"
        static let privateKey: String = "f287e8fc84a9702c32ae83cc4d21ed2d0ecee2f2"
    }

    var MD5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    // MARK: - String + localized
    var localized: String {
        return NSLocalizedString(self,
                                 value: "**\(self)**",
                                 comment: "")
    }
}
