//
//  ReusableView.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 5/4/21.
//

import UIKit

// MARK: - ReusableView

/// Classes adopting this protocol are supposed to have reuse identifier equal to their names
protocol ReusableView {
    static var reuseIdentifier: String { get }
}

// MARK: - ReusableView default implementation
extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: ReusableView { }

// MARK: - NibLoadable

/// Classes adopting this protocol are supposed to be loaded from a nib file using a filename equal to their names
protocol NibLoadable {
    static var nibFile: UINib { get }
}

// MARK: - NibLoadable default implementation
extension NibLoadable where Self: UIView {
    static var nibFile: UINib {
        let bundle = Bundle(for: self)
        return UINib(nibName: self.reuseIdentifier, bundle: bundle)
    }
}

// MARK: - UITableView + ReusableView
extension UITableView {
    func dequeueReusableCell<T: ReusableView>(withType type: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: type.reuseIdentifier) as! T
    }
    
    func registerReusableCell<T: ReusableView & NibLoadable>(withType type: T.Type) {
        self.register(type.nibFile, forCellReuseIdentifier: type.reuseIdentifier)
    }
}
