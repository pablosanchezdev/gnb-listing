//
//  Swinject.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/04/2021.
//  Copyright © 2021 Pablo Sanchez. All rights reserved.
//

import UIKit
import Swinject

let assembly: Assembly = SwinjectAssembly()

class SwinjectAssembly {
    private let container = Container()
    private var indexSelected: Int!
    
    fileprivate init() {
        registerDependencies()
    }
}

// MARK: - Assembly methods
extension SwinjectAssembly: Assembly {
    func transactionListViewController() -> TransactionListViewController {
        return container.resolve(TransactionListViewController.self)!
    }
    
    func transactionListCoordinator() -> Coordinable {
        return container.resolve(TransactionListCoordinatorProtocol.self)!
    }
    
    func productDetailViewController() -> ProductDetailViewController {
        return container.resolve(ProductDetailViewController.self)!
    }
    
    func productDetailCoordinator(index: Int) -> Coordinable {
        indexSelected = index
        return container.resolve(ProductDetailCoordinatorProtocol.self)!
    }
}

// MARK: - Private methods
private extension SwinjectAssembly {
    func registerDependencies() {
        registerDomainLayerDependencies()
        registerDataLayerDependencies()
        registerPresentationLayerDependencies()
    }
    
    func registerDomainLayerDependencies() {
        container.register(TransactionStorage.self) { _ in TransactionStorage() }.inObjectScope(.container)
    }
    
    func registerDataLayerDependencies() {
        container.register(Decoder.self) { _ in JsonDecoder() }
        container.register(APIClient.self) { _ in AlamofireAPIClient() }
        container.register(TransactionRepository.self) { r in
            let apiClient = r.resolve(APIClient.self)!
            let decoder = r.resolve(Decoder.self)!
            
            return RemoteTransactionRepository(apiClient: apiClient, decoder: decoder)
        }
    }
    
    func registerPresentationLayerDependencies() {
        registerTransactionListDependencies()
        registerProductDetailDependencies()
    }
    
    func registerTransactionListDependencies() {
        container
            .register(TransactionListCoordinatorProtocol.self) { _ in TransactionListCoordinator() }
            .initCompleted { (_, c) in c.start() }
        container
            .register(TransactionListPresenter.self) { r in
                let coordinator = r.resolve(TransactionListCoordinatorProtocol.self)!
                let repository = r.resolve(TransactionRepository.self)!
                let storage = r.resolve(TransactionStorage.self)!
                
                return TransactionListPresenter(coordinator: coordinator, repository: repository, storage: storage)
            }
            .initCompleted { (r, presenter) in
                presenter.view = r.resolve(TransactionListViewController.self)
            }
        container.register(TransactionListViewController.self) { r in
            let presenter = r.resolve(TransactionListPresenter.self)!
            
            return TransactionListViewController(presenter: presenter)
        }
    }
    
    func registerProductDetailDependencies() {
        container
            .register(ProductDetailCoordinatorProtocol.self) { _ in ProductDetailCoordinator() }
            .initCompleted { (_, c) in c.start() }
        container
            .register(ProductDetailPresenter.self) { [unowned self] r in
                let storage = r.resolve(TransactionStorage.self)!
                let coordinator = r.resolve(ProductDetailCoordinatorProtocol.self)!
                let repository = r.resolve(TransactionRepository.self)!
                
                return ProductDetailPresenter(index: indexSelected,
                                              storage: storage,
                                              coordinator: coordinator,
                                              repository: repository)
            }
            .initCompleted { (r, presenter) in
                presenter.view = r.resolve(ProductDetailViewController.self)
            }
        container.register(ProductDetailViewController.self) { r in
            let presenter = r.resolve(ProductDetailPresenter.self)!
            
            return ProductDetailViewController(presenter: presenter)
        }
    }
}
