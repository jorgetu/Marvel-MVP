//
//  UITableView.swift
//  Marvel-MVP
//
//  Created by Jorge Arias Brasa on 06/02/2021.
//

import Foundation
import UIKit

internal extension UITableView {

    // MARK: - UITableView + ReusableCell
    /**
        Register a View conforming the ReusableView and NibLoadableView protocols to a UITableView
     **/
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableCell, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)

        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    /**
        Dequeue a reusable cell conforming the ReusableView protocol
     **/
    func dequeueReusableCell<T: UITableViewCell>(_: T.Type) -> T where T: ReusableCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

    /**
        Dequeue a reusable cell conforming the ReusableView protocol for an IndexPath
     **/
    func dequeueReusableCell<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}
