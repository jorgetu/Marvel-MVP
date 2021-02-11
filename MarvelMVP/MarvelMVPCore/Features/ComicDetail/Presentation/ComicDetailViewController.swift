//
//  ComicDetailViewController.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 09/02/2021.
//

import UIKit

protocol ComicDetailViewControllerProviderProtocol: class {
    func comicDetailViewController<T>(item: T) -> UIViewController?
}

internal protocol ComicDetailViewProtocol: class {
    var title: String? { get set }
    func showComic(comic: Comic)
}

internal final class ComicDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var comicName: UILabel!
    @IBOutlet var comicImage: UIImageView!
    
    // MARK: - Properties
    private let presenter: ComicDetailPresenterProtocol

    // MARK: - Initializers
    init(presenter: ComicDetailPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.loadView()
    }
}

// MARK: - DetailView
extension ComicDetailViewController: ComicDetailViewProtocol {

    func showComic(comic: Comic) {
        if let title = comic.title {
            // TO DO Add pending values to screen
            self.comicName.text = title
            comicImage.sd_setImage(with: comic.thumbnail, placeholderImage: UIImage(named: "placeholder.png"))
        }
    }

}

