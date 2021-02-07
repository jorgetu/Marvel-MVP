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
    
    @IBOutlet var comicTitle: UILabel!
    @IBOutlet var comicImage: UIImageView!
    
    
    // MARK: - Lifecycle Methods
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    // MARK: - Internal Methods
    func bind(with comic: Comic?) {
        if let comic = comic {
            comicTitle.isHidden = false
            comicTitle.text = comic.title
        }else{
            comicTitle.isHidden = true
        }
    }

}
