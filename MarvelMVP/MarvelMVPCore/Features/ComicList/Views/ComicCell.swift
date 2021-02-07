//
//  ComicCell.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation

import Foundation
import UIKit

internal final class ComicCell: UITableViewCell, NibLoadableView, ReusableCell {

    // MARK: - IBOutlets
    
    @IBOutlet var comicName: UILabel!
    @IBOutlet var comicImage: UIImageView!
    
    
    // MARK: - Lifecycle Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        comicName.text = nil
    }

    // MARK: - Internal Methods
    func bind(with comic: Comic?) {

        if let comic = comic {
            comicName.isHidden = false
            comicName.text = comic.title
        }else{
            comicName.isHidden = true
        }
    }

}
