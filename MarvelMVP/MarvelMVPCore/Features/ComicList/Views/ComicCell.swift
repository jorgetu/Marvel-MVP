//
//  ComicCell.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation
import UIKit
import SDWebImage

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
            comicImage.isHidden = false
            comicTitle.text = comic.title
            comicImage.sd_cancelCurrentImageLoad()
            comicImage.image = UIImage.init(systemName: "house")  // TO DO
            comicImage.sd_setImage(with: comic.thumbnail, placeholderImage: UIImage(named: "placeholder.png"))
        } else {
            comicTitle.isHidden = true
            comicImage.isHidden = true
        }
    }

}
