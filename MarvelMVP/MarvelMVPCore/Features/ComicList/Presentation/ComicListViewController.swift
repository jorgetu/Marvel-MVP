//
//  ComicListViewController.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation
import UIKit

internal protocol ComicListViewProtocol: class {
    func setLoading(_ loading: Bool)
    func update()
    func showError(_ error: ServiceError)
}


internal final class ComicListViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var comicListTableView: UITableView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var retryLabel: UILabel!
    
    // MARK: - Properties
    private let presenter: ComicListPresenterProtocol
    
    private enum Constants {
        static let activityIndicatorHeight: CGFloat = 40
        static let retryButtonAnimationDuration: TimeInterval = 0.5
        static let retryButtonAlpha: CGFloat = 0.2
    }

    // MARK: - Variables
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 0.1921568627, green: 0.631372549, blue: 0.5411764706, alpha: 1)
        return refreshControl
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: comicListTableView.bounds.width,
                           height: Constants.activityIndicatorHeight)
        let activityIndicator = UIActivityIndicatorView(frame: frame)
        activityIndicator.color = #colorLiteral(red: 0.1921568627, green: 0.631372549, blue: 0.5411764706, alpha: 1)
        activityIndicator.tintColor = #colorLiteral(red: 0.1921568627, green: 0.631372549, blue: 0.5411764706, alpha: 1)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // MARK: - Initializers
    init(presenter: ComicListPresenterProtocol) {
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

        configureUI()
        presenter.loadView()
    }
    

    // MARK: - Private Methods
    private func configureUI() {

        comicListTableView.accessibilityIdentifier = "ComicListTableView"
        comicListTableView.register(ComicCell.self)
        comicListTableView.tableFooterView = activityIndicator
        
        errorView.isHidden = true
    }

    @objc private func refreshComics() {
        presenter.fetchComicList()
    }

    private func animateRetryButton() {

        UIView.animate(withDuration: Constants.retryButtonAnimationDuration,
                       delay: 0,
                       options: [.autoreverse, .repeat],
                       animations: { [weak self] in

                        self?.retryLabel.alpha = Constants.retryButtonAlpha
        })
    }

    // MARK: - IBActions
    @IBAction func retryButtonTapped(_ sender: UIButton) {

        errorView.isHidden = true
        refreshComics()
    }
}

// MARK: - ComicListViewController
extension ComicListViewController: ComicListViewProtocol {

    func setLoading(_ loading: Bool) {

        _ = loading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }

    func update() {
        comicListTableView.reloadData()

        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

    func showError(_ error: ServiceError) {

        errorLabel.text = error.localizedDescription
        animateRetryButton()
        errorView.isHidden = false
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ComicListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        return presenter.comicList.list.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(ComicCell.self, for: indexPath)

        cell.bind(with: presenter.comicList.list[indexPath.row])
        cell.accessibilityIdentifier = "ComicCell_\(indexPath.row)"
        return cell
    }
}
