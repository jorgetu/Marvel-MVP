//
//  UILabel.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 09/02/2021.
//

import UIKit

public extension UILabel {

    // MARK: - UILabel + localized
    @IBInspectable var localizedText: String {
        get {
            return text ?? ""
        }
        set {
            text = newValue.localized
        }
    }
}
