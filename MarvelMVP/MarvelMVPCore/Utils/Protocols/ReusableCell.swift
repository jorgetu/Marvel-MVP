//
//  ReusableCell.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import UIKit

public protocol ReusableCell: class {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell where Self: UITableViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
