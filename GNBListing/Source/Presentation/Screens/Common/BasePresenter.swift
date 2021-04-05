//
//  BasePresenter.swift
//  GNBListing
//
//  Created by Pablo Sanchez on 5/4/21.
//

import Foundation

enum ViewState {
    case didLoad
    case willAppear
    case didAppear
    case willDisappear
    case didDisappear
}

class BasePresenter {
    func prepareView(for state: ViewState) {
        preconditionFailure("BasePresenter: prepareView(for:) has not been implemented")
    }
}
