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
    var title: String? { get set }
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
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: comicListTableView.bounds.width,
                           height: Constants.activityIndicatorHeight)
        let activityIndicator = UIActivityIndicatorView(frame: frame)
        activityIndicator.color = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        activityIndicator.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    internal var isFilterEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
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
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "comicFilter_search_comics".localized
        navigationItem.searchController = searchController
    }
    
    // MARK: - Private Methods
    private func configureUI() {

        comicListTableView.register(ComicCell.self)
        comicListTableView.tableFooterView = activityIndicator
        
        errorView.isHidden = true
    }

    @objc private func refreshComics() {
        let startsWith = isFilterEmpty ? nil : searchController.searchBar.text
        presenter.fetchComicList(startsWith: startsWith)
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
        // We add one row in case the user arrives to the end, we will fetch more rows
        return min(presenter.currentComicList.list.count + 1, presenter.currentComicList.totalItems)
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(ComicCell.self, for: indexPath)

        if isLoadingCell(for: indexPath) {  // The blank cell
            cell.bind(with: nil)
        } else {
            cell.bind(with: presenter.currentComicList.list[indexPath.row])
            cell.accessibilityIdentifier = "ComicCell_\(indexPath.row)"
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        let comic = presenter.currentComicList.list[indexPath.row]
        presenter.didSelect(comic: comic)
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension ComicListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            let startsWith = isFilterEmpty ? nil : searchController.searchBar.text
            presenter.fetchComicList(startsWith: startsWith)
         }
      }
}

private extension ComicListViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= presenter.currentComicList.list.count && indexPath.row <= presenter.currentComicList.totalItems
    }
}

extension ComicListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    var textToSearch: String? = searchBar.text
    
    if let safeText = searchBar.text, !safeText.isEmpty {
        textToSearch = safeText
    } else {
        textToSearch = nil
    }
    
    NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: textToSearch)
    perform(#selector(self.reload(_:)), with: textToSearch, afterDelay: 0.75)
  }
    
    @objc func reload(_ text: String?) {
        presenter.preFetchComicList(startsWith: text)
    }
}
