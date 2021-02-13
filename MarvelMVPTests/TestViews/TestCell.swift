//
//  TestCell.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 13/02/2021.
//

import UIKit
@testable import Marvel_MVP

internal final class TestCell: UITableViewCell, NibLoadableView, ReusableCell {

    // MARK: - IBOutlets
    @IBOutlet weak var testLabel: UILabel!
}
