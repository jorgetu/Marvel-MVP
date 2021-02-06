//
//  NibLoadableView.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation
import UIKit

public protocol NibLoadableView: class {
    static var nibName: String { get }
    static func instantiate() -> Self
}

public extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }

    static func instantiate() -> Self {
        if let nib = UINib(nibName: nibName,
                           bundle: Bundle(for: Self.self))
                    .instantiate(withOwner: nil, options: nil)[0] as? Self {
            return nib
        } else {
            fatalError("Failed to load .xib named \(nibName) in bundle \(Bundle(for: Self.self))")
        }
    }
}
